clear all; close all; clc;

%% PARAMETERS
f_s = 16000; % sampling frequency (Hz).
snr_ind = -20:5:30; % SNR levels for individual conditions.
snr_avg = -5:5:15; % SNR levels to compute average from.

%% HYPOTHESIS TRANSCRIPT DIRECTORY
hyp_trans.dir = {
    '/mnt/hdd1/out/tgt_20/hyp_trans/noisy_speech',...
    };

%% LIBRISPEECH TEST CLEAN DIRECTORY
ref_trans.dir = '/mnt/hdd1/speech/librispeech/LibriSpeech/test-clean';

%% OBJECTIVE SCORES DIRECTORY
res_dir = 'results/';
if ~exist(res_dir, 'dir')
    mkdir(res_dir)
end

%% OBJECTIVE SCORING
for i = 1:length(hyp_trans.dir)

    results = MapNested();
    split_str = strsplit(hyp_trans.dir{i}, '/');
    ver = split_str{end};
    hyp_trans.paths = dir([hyp_trans.dir{i}, '/*.txt']);
    noise_src_set = {};
    snr_set = {};
    
    for j = 1:length(hyp_trans.paths)

        hyp_trans.string = fileread([hyp_trans.dir{i}, '/', hyp_trans.paths(j).name]);

        split_str = strsplit(hyp_trans.paths(j).name, '_');
        noise_src = split_str{2};
        snr = split_str{3}(1:end-6);
        split_str = strsplit(split_str{1}, '-');
        speaker = split_str{1};
        chapter = split_str{2};
        utterance = split_str{3};

        ref_trans.string = fileread([ref_trans.dir, '/', speaker, '/', ...
            chapter, '/' speaker, '-', chapter, '.trans.txt']);
        ref_trans.string = regexp(ref_trans.string, '\n', 'split');
        ref_trans.string = ref_trans.string(~cellfun(@isempty, ...
            regexp(ref_trans.string, [speaker, '-', chapter, '-', utterance])));
        ref_trans.string = lower(erase(ref_trans.string, [speaker, '-', ...
            chapter, '-', utterance, ' ']));
        ref_trans.string = ref_trans.string{1};

        wer = WER(strtrim(hyp_trans.string), strtrim(ref_trans.string));

        results = add_score(wer(1), results, noise_src, snr);
        
        if ~any(strcmp(noise_src_set, noise_src))
            noise_src_set{end+1} = noise_src;
        end
    
        clc;
        fprintf('%.2f%%\n', 100*j/length(hyp_trans.paths));
    end
    
    fileID = fopen([res_dir, '/', ver, '.csv'],'w');
    fprintf(fileID, 'noise_src, snr_db, wer\n');
    
    
    avg = [];

    for j = 1:length(noise_src_set)
        for k = snr_ind
    
            snr_str = num2str(k);
    
            wer = mean(results(noise_src_set{j}, snr_str));
    
            fprintf(fileID, '%s, %s, %.2f\n', ...
                noise_src_set{j}, snr_str, 100*wer);

            if ismember(k, snr_avg)
            	avg = [avg; results(noise_src_set{j}, snr_str)];
            end
        end
    end
    fclose(fileID);
    
    avg_path = [res_dir, '/average.csv'];
    
    if ~exist(avg_path, 'file')
        fileID = fopen(avg_path, 'w');
        fprintf(fileID, 'ver, WER\n');
        fclose(fileID);
    end
    
    fileID = fopen(avg_path, 'a');
    fprintf(fileID, '%s, %.2f\n', ver, 100*mean(avg));
    fclose(fileID);
end
% EOF

% The tgt_20 project.
% Copyright (C) 2020  Aaron Nicolson
%
% This program is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
%
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with this program.  If not, see <https://www.gnu.org/licenses/>.

clear all; close all; clc;

indi_flag = 0;
mean_flag = 1;

%% PARAMETERS
f_s = 16000; % sampling frequency (Hz).
snr = -5:5:15; % SNR levels to test.

%% HYPOTHESIS TRANSCRIPT DIRECTORY
hyp_trans.dir = {
	  '/mnt/hdd1/out/tgt_20/hyp_trans/noisy_speech',...
    '/mnt/hdd1/out/tgt_20/hyp_trans/ibm_mse_e150',...
    '/mnt/hdd1/out/tgt_20/hyp_trans/ibm_e150',...
    '/mnt/hdd1/out/tgt_20/hyp_trans/irm_mse_e150',...
    '/mnt/hdd1/out/tgt_20/hyp_trans/irm_e150',...
    '/mnt/hdd1/out/tgt_20/hyp_trans/mag_norm_e150',...
    '/mnt/hdd1/out/tgt_20/hyp_trans/pow_db_e150',...
    '/mnt/hdd1/out/tgt_20/hyp_trans/pow_db_std_e150',...
    '/mnt/hdd1/out/tgt_20/hyp_trans/pow_db_norm_mse_e150',...
    '/mnt/hdd1/out/tgt_20/hyp_trans/pow_db_norm_e150',...
    '/mnt/hdd1/out/tgt_20/hyp_trans/mag_bar_mse_e150',...
    '/mnt/hdd1/out/tgt_20/hyp_trans/mag_bar_e150',...
    '/mnt/hdd1/out/tgt_20/hyp_trans/xi_db_e150_mmse-lsa',...
    '/mnt/hdd1/out/tgt_20/hyp_trans/xi_db_e150_srwf',...
    '/mnt/hdd1/out/tgt_20/hyp_trans/xi_db_std_e150_mmse-lsa',...
    '/mnt/hdd1/out/tgt_20/hyp_trans/xi_db_std_e150_srwf',...
    '/mnt/hdd1/out/tgt_20/hyp_trans/xi_db_norm_mse_e150_mmse-lsa',...
    '/mnt/hdd1/out/tgt_20/hyp_trans/xi_db_norm_mse_e150_srwf',...
    '/mnt/hdd1/out/tgt_20/hyp_trans/xi_db_norm_e150_mmse-lsa',...
    '/mnt/hdd1/out/tgt_20/hyp_trans/xi_db_norm_e150_srwf',...
    '/mnt/hdd1/out/tgt_20/hyp_trans/xi_bar_mse_e150_mmse-lsa',...
    '/mnt/hdd1/out/tgt_20/hyp_trans/xi_bar_mse_e150_srwf',...
    '/mnt/hdd1/out/tgt_20/hyp_trans/xi_bar_e150_mmse-lsa',...
    '/mnt/hdd1/out/tgt_20/hyp_trans/xi_bar_e150_srwf',...
    '/mnt/hdd1/out/tgt_20/hyp_trans/xi_gamma_db_e150_mmse-lsa',...
    '/mnt/hdd1/out/tgt_20/hyp_trans/xi_gamma_bar_mse_e150_mmse-lsa',...
    '/mnt/hdd1/out/tgt_20/hyp_trans/xi_gamma_bar_e150_mmse-lsa',...
    };

hyp_trans.dir = {
    '/mnt/hdd1/out/tgt_20/hyp_trans/xi_gamma_db_norm_mse_e150_mmse-lsa',...
    '/mnt/hdd1/out/tgt_20/hyp_trans/xi_gamma_db_norm_e150_mmse-lsa',...
    };

%% LIBRISPEECH TEST CLEAN DIRECTORY
ref_trans.dir = '/mnt/hdd1/set/librispeech/LibriSpeech/test-clean';

%% OBJECTIVE SCORES DIRECTORY
res_dir = 'res/';
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
        snr_str = split_str{3}(1:end-6);
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

				% disp(strtrim(hyp_trans.string))
				% disp(strtrim(ref_trans.string))
				% disp("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA")

        wer = WER(strtrim(hyp_trans.string), strtrim(ref_trans.string));

        results = add_score(wer(1), results, noise_src, snr_str);

        if ~any(strcmp(noise_src_set, noise_src))
            noise_src_set{end+1} = noise_src;
        end

        clc;
        fprintf('%.2f%%\n', 100*j/length(hyp_trans.paths));
    end

		%%
    metrics = {'WER'};

    %%
    for j=1:length(metrics)
        for l = 1:length(noise_src_set)
            if ~exist([res_dir, '/', metrics{j}, '_', noise_src_set{l}, '.csv'], 'file')
                fileID = fopen([res_dir, '/', metrics{j}, '_', noise_src_set{l}, '.csv'], 'w');
                fprintf(fileID, 'noise, ver');
                for k=snr
                    fprintf(fileID, ', %d', k);
                end
                fprintf(fileID, '\n', k);
                fclose(fileID);
            end
        end
    end

    avg.WER = [];
    for j = 1:length(noise_src_set)

        for l=1:length(metrics)
            fileID = fopen([res_dir, '/', metrics{l}, '_', noise_src_set{j}, '.csv'], 'a');
            fprintf(fileID, '%s, %s', noise_src_set{j}, ver);
            fclose(fileID);
        end

        for k = snr

            snr_str = num2str(k);

            if indi_flag
                fileID = fopen([res_dir, '/WER', '_', noise_src_set{j}, '.csv'], 'a');
                fprintf(fileID, ', %.2f', mean(results(noise_src_set{j}, snr_str))*100);
                fclose(fileID);
            end

            avg.WER = [avg.WER; results(noise_src_set{j}, snr_str)];

        end

        for l=1:length(metrics)
            fileID = fopen([res_dir, '/', metrics{l}, '_', noise_src_set{j}, '.csv'], 'a');
            fprintf(fileID, '\n');
            fclose(fileID);
        end
    end

    save([res_dir, '/', ver, '.mat'], 'avg');

    if mean_flag
        avg_path = [res_dir, '/average.csv'];

        if ~exist(avg_path, 'file')
            fileID = fopen(avg_path, 'w');
            fprintf(fileID, 'ver, WER\n');
            fclose(fileID);
        end

        fileID = fopen(avg_path, 'a');
        fprintf(fileID, '%s, %.2f\n', ver, 100*mean(avg.WER));
        fclose(fileID);
    end
end
% EOF

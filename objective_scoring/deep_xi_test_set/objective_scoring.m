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

%% PROCESSED (ENHANCED) SPEECH DIRECTORIES
y.dirs = {
    '/home/aaron/set/deep_xi_test_set/test_noisy_speech',...
    '/mnt/hdd1/out/tgt_20/ibm_mse/e150/y',...
    '/mnt/hdd1/out/tgt_20/ibm/e150/y',...
    '/mnt/hdd1/out/tgt_20/irm_mse/e150/y',...
    '/mnt/hdd1/out/tgt_20/irm/e150/y',...
    '/mnt/hdd1/out/tgt_20/mag_norm/e150/y',...
    '/mnt/hdd1/out/tgt_20/pow_db/e150/y',...
    '/mnt/hdd1/out/tgt_20/pow_db_std/e150/y',...
    '/mnt/hdd1/out/tgt_20/pow_db_norm_mse/e150/y',...
    '/mnt/hdd1/out/tgt_20/pow_db_norm/e150/y',...
    '/mnt/hdd1/out/tgt_20/mag_bar_mse/e150/y',...
    '/mnt/hdd1/out/tgt_20/mag_bar/e150/y',...
    '/mnt/hdd1/out/tgt_20/xi_db/e150/y/mmse-lsa',...
    '/mnt/hdd1/out/tgt_20/xi_db/e150/y/srwf',...
    '/mnt/hdd1/out/tgt_20/xi_db_norm_mse/e150/y/mmse-lsa',...
    '/mnt/hdd1/out/tgt_20/xi_db_norm_mse/e150/y/srwf',...
    '/mnt/hdd1/out/tgt_20/xi_db_norm/e150/y/mmse-lsa',...
    '/mnt/hdd1/out/tgt_20/xi_db_norm/e150/y/srwf',...
    '/mnt/hdd1/out/tgt_20/xi_bar_mse/e150/y/mmse-lsa',...
    '/mnt/hdd1/out/tgt_20/xi_bar_mse/e150/y/srwf',...
    '/mnt/hdd1/out/tgt_20/xi_bar/e150/y/mmse-lsa',...
    '/mnt/hdd1/out/tgt_20/xi_bar/e150/y/srwf',...
    '/mnt/hdd1/out/tgt_20/xi_gamma_db/e150/y/mmse-lsa',...
    '/mnt/hdd1/out/tgt_20/xi_gamma_bar/e150/y/mmse-lsa',...
    '/mnt/hdd1/out/tgt_20/xi_gamma_bar_mse/e150/y/mmse-lsa',...
    '/mnt/hdd1/out/tgt_20/xi_db_std/e150/y/mmse-lsa',...
    '/mnt/hdd1/out/tgt_20/xi_db_std/e150/y/srwf',...
    };

y.dirs = {
    '/home/aaron/set/deep_xi_test_set/test_noisy_speech',...
    '/mnt/hdd1/out/tgt_20/irm_mse/e150/y',...
    '/mnt/hdd1/out/tgt_20/irm/e150/y',...
    '/mnt/hdd1/out/tgt_20/mag_norm/e150/y',...
    '/mnt/hdd1/out/tgt_20/pow_db/e150/y',...
    '/mnt/hdd1/out/tgt_20/xi_bar_mse/e150/y/mmse-lsa',...
    '/mnt/hdd1/out/tgt_20/xi_bar/e150/y/mmse-lsa',...
    '/mnt/hdd1/out/tgt_20/xi_gamma_bar/e150/y/mmse-lsa',...
    '/mnt/hdd1/out/tgt_20/xi_gamma_bar_mse/e150/y/mmse-lsa',...
    };

y.dirs = {
    '/mnt/hdd1/out/tgt_20/xi_gamma_db_norm_mse/e150/y/mmse-lsa',...
    '/mnt/hdd1/out/tgt_20/xi_gamma_db_norm/e150/y/mmse-lsa',...
    };

%% REFERENCE (CLEAN) SPEECH DIRECTORY
s.paths = dir('/home/aaron/set/deep_xi_test_set/test_clean_speech/*.wav');

%% OBJECTIVE SCORES DIRECTORY
res_dir = 'results';
if ~exist(res_dir, 'dir')
    mkdir(res_dir)
end

%% OBJECTIVE SCORING
for i = 1:length(y.dirs)

    noise_src_set = {};
    results = MapNested();

    split_str = strsplit(y.dirs{i}, '/');

    if strcmp(split_str{end-1}, 'y')
        ver = [split_str{end-3}, '_', split_str{end-2}, '_', split_str{end}];
    elseif strcmp(split_str{end}, 'y')
        ver = [split_str{end-2}, '_', split_str{end-1}];
    elseif strcmp(split_str{end}, 'test_noisy_speech')
        ver = 'noisy_speech';
    else
        error('Version error')
    end

    for j = 1:length(s.paths)
        for k = snr

            s.wav = audioread([s.paths(j).folder, '/', s.paths(j).name]);

            split_basename = strsplit(s.paths(j).name, '_');
            noise_src = split_basename{end}(1:end-4);
            snr_str = num2str(k);

            y.wav = audioread([y.dirs{i}, '/', s.paths(j).name(1:end-4), ...
                '_', snr_str, 'dB.wav']);

            y.wav = y.wav(1:length(s.wav));

            if any(isnan(y.wav(:))) || any(isinf(y.wav(:)))
                error('NaN or Inf value in enhanced speech.')
            end

            if ~any(strcmp(noise_src_set, noise_src))
                noise_src_set{end+1} = noise_src;
            end

            [CSIG, CBAK, COVL] = composite(s.wav, y.wav, f_s);
            PESQ = pesq(s.wav, y.wav, f_s);
            STOI = stoi(s.wav, y.wav, f_s);
            [~, SegSNR]= comp_snr(s.wav, y.wav, f_s);

            results = add_score(CSIG, results, noise_src, snr_str, 'CSIG');
            results = add_score(CBAK, results, noise_src, snr_str, 'CBAK');
            results = add_score(COVL, results, noise_src, snr_str, 'COVL');
            results = add_score(PESQ, results, noise_src, snr_str, 'PESQ');
            results = add_score(STOI, results, noise_src, snr_str, 'STOI');
            results = add_score(SegSNR, results, noise_src, snr_str, 'SegSNR');

        end
        clc;
        fprintf('%.2f%%\n', 100*j/length(s.paths));
    end

    %%
    metrics = {'CSIG', 'CBAK', 'COVL', 'PESQ', 'STOI', 'SegSNR'};

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

    avg.CSIG = [];
    avg.CBAK = [];
    avg.COVL = [];
    avg.PESQ = [];
    avg.STOI = [];
    avg.SegSNR = [];
    for j = 1:length(noise_src_set)

        for l=1:length(metrics)
            fileID = fopen([res_dir, '/', metrics{l}, '_', noise_src_set{j}, '.csv'], 'a');
            fprintf(fileID, '%s, %s', noise_src_set{j}, ver);
            fclose(fileID);
        end

        for k = snr

            snr_str = num2str(k);

            CSIG = mean(results(noise_src_set{j}, snr_str, 'CSIG'));
            CBAK = mean(results(noise_src_set{j}, snr_str, 'CBAK'));
            COVL = mean(results(noise_src_set{j}, snr_str, 'COVL'));
            PESQ = mean(results(noise_src_set{j}, snr_str, 'PESQ'));
            STOI = mean(results(noise_src_set{j}, snr_str, 'STOI'));
            SegSNR = mean(results(noise_src_set{j}, snr_str, 'SegSNR'));


            if indi_flag
                fileID = fopen([res_dir, '/CSIG', '_', noise_src_set{j}, '.csv'], 'a');
                fprintf(fileID, ', %.2f', CSIG);
                fclose(fileID);

                fileID = fopen([res_dir, '/CBAK', '_', noise_src_set{j}, '.csv'], 'a');
                fprintf(fileID, ', %.2f', CBAK);
                fclose(fileID);

                fileID = fopen([res_dir, '/COVL', '_', noise_src_set{j}, '.csv'], 'a');
                fprintf(fileID, ', %.2f', COVL);
                fclose(fileID);

                fileID = fopen([res_dir, '/PESQ', '_', noise_src_set{j}, '.csv'], 'a');
                fprintf(fileID, ', %.2f', PESQ);
                fclose(fileID);

                fileID = fopen([res_dir, '/STOI', '_', noise_src_set{j}, '.csv'], 'a');
                fprintf(fileID, ', %.2f', STOI*100);
                fclose(fileID);

                fileID = fopen([res_dir, '/SegSNR', '_', noise_src_set{j}, '.csv'], 'a');
                fprintf(fileID, ', %.2f', SegSNR);
                fclose(fileID);
            end

            avg.CSIG = [avg.CSIG; results(noise_src_set{j}, snr_str, 'CSIG')];
            avg.CBAK = [avg.CBAK; results(noise_src_set{j}, snr_str, 'CBAK')];
            avg.COVL = [avg.COVL; results(noise_src_set{j}, snr_str, 'COVL')];
            avg.PESQ = [avg.PESQ; results(noise_src_set{j}, snr_str, 'PESQ')];
            avg.STOI = [avg.STOI; results(noise_src_set{j}, snr_str, 'STOI')];
            avg.SegSNR = [avg.SegSNR; results(noise_src_set{j}, snr_str, 'SegSNR')];

        end

        for l=1:length(metrics)
            fileID = fopen([res_dir, '/', metrics{l}, '_', noise_src_set{j}, '.csv'], 'a');
            fprintf(fileID, '\n');
            fclose(fileID);
        end
    end

    save(['./results/', ver, '.mat'], 'avg');

    if mean_flag
        avg_path = [res_dir, '/average.csv'];

        if ~exist(avg_path, 'file')
            fileID = fopen(avg_path, 'w');
            fprintf(fileID, 'ver, CSIG, CBAK, COVL, PESQ, STOI, SegSNR\n');
            fclose(fileID);
        end

        fileID = fopen(avg_path, 'a');
        fprintf(fileID, '%s, %.2f, %.2f, %.2f, %.2f, %.2f, %.2f\n', ver, ...
            mean(avg.CSIG), mean(avg.CBAK), mean(avg.COVL), ...
            mean(avg.PESQ), 100*mean(avg.STOI), ...
            mean(avg.SegSNR));
        fclose(fileID);
    end
end
% EOF

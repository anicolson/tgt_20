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

%% PARAMETERS
f_s = 16000; % sampling frequency (Hz).
snr_ind = -5:5:15; % SNR levels for individual conditions.

%% HYPOTHESIS TRANSCRIPT DIRECTORY
hyp_trans.dir = {
    '/mnt/hdd1/out/tgt_20/hyp_trans/demand_vb/noisy_speech',...
    '/mnt/hdd1/out/tgt_20/hyp_trans/demand_vb/ibm_mse_e125',...
    '/mnt/hdd1/out/tgt_20/hyp_trans/demand_vb/ibm_e125',...
    '/mnt/hdd1/out/tgt_20/hyp_trans/demand_vb/irm_mse_e125',...
    '/mnt/hdd1/out/tgt_20/hyp_trans/demand_vb/irm_e125',...
    '/mnt/hdd1/out/tgt_20/hyp_trans/demand_vb/mag_norm_e125',...
    '/mnt/hdd1/out/tgt_20/hyp_trans/demand_vb/pow_db_e125',...
    '/mnt/hdd1/out/tgt_20/hyp_trans/demand_vb/pow_db_std_e125',...
    '/mnt/hdd1/out/tgt_20/hyp_trans/demand_vb/pow_db_norm_mse_e125',...
    '/mnt/hdd1/out/tgt_20/hyp_trans/demand_vb/pow_db_norm_e125',...
    '/mnt/hdd1/out/tgt_20/hyp_trans/demand_vb/mag_bar_mse_e125',...
    '/mnt/hdd1/out/tgt_20/hyp_trans/demand_vb/mag_bar_e125',...
    '/mnt/hdd1/out/tgt_20/hyp_trans/demand_vb/xi_norm_mse_e125_mmse-lsa',...
    '/mnt/hdd1/out/tgt_20/hyp_trans/demand_vb/xi_norm_mse_e125_srwf',...
    '/mnt/hdd1/out/tgt_20/hyp_trans/demand_vb/xi_norm_e125_mmse-lsa',...
    '/mnt/hdd1/out/tgt_20/hyp_trans/demand_vb/xi_norm_e125_srwf',...
    '/mnt/hdd1/out/tgt_20/hyp_trans/demand_vb/xi_db_e125_mmse-lsa',...
    '/mnt/hdd1/out/tgt_20/hyp_trans/demand_vb/xi_db_e125_srwf',...
    '/mnt/hdd1/out/tgt_20/hyp_trans/demand_vb/xi_db_std_e125_mmse-lsa',...
    '/mnt/hdd1/out/tgt_20/hyp_trans/demand_vb/xi_db_std_e125_srwf',...
    '/mnt/hdd1/out/tgt_20/hyp_trans/demand_vb/xi_db_norm_mse_e125_mmse-lsa',...
    '/mnt/hdd1/out/tgt_20/hyp_trans/demand_vb/xi_db_norm_mse_e125_srwf',...
    '/mnt/hdd1/out/tgt_20/hyp_trans/demand_vb/xi_db_norm_e125_mmse-lsa',...
    '/mnt/hdd1/out/tgt_20/hyp_trans/demand_vb/xi_db_norm_e125_srwf',...
    '/mnt/hdd1/out/tgt_20/hyp_trans/demand_vb/xi_bar_mse_e125_mmse-lsa',...
    '/mnt/hdd1/out/tgt_20/hyp_trans/demand_vb/xi_bar_mse_e125_srwf',...
    '/mnt/hdd1/out/tgt_20/hyp_trans/demand_vb/xi_bar_e125_mmse-lsa',...
    '/mnt/hdd1/out/tgt_20/hyp_trans/demand_vb/xi_bar_e125_srwf',...
    '/mnt/hdd1/out/tgt_20/hyp_trans/demand_vb/xi_gamma_norm_e125_mmse-lsa',...
    '/mnt/hdd1/out/tgt_20/hyp_trans/demand_vb/xi_gamma_db_e125_mmse-lsa',...
    '/mnt/hdd1/out/tgt_20/hyp_trans/demand_vb/xi_gamma_db_norm_mse_e125_mmse-lsa',...
    '/mnt/hdd1/out/tgt_20/hyp_trans/demand_vb/xi_gamma_db_norm_e125_mmse-lsa',...
    '/mnt/hdd1/out/tgt_20/hyp_trans/demand_vb/xi_gamma_bar_mse_e125_mmse-lsa',...
    '/mnt/hdd1/out/tgt_20/hyp_trans/demand_vb/xi_gamma_bar_e125_mmse-lsa',...
    };

%% LIBRISPEECH TEST CLEAN DIRECTORY
ref_trans.dir = '/mnt/hdd1/set/VCTK/txt';

%% OBJECTIVE SCORES DIRECTORY
res_dir = 'res';
if ~exist(res_dir, 'dir')
    mkdir(res_dir)
end

%% OBJECTIVE SCORING
for i = 1:length(hyp_trans.dir)

    results = [];
    split_str = strsplit(hyp_trans.dir{i}, '/');
    ver = split_str{end};
    hyp_trans.paths = dir([hyp_trans.dir{i}, '/*.txt']);
    noise_src_set = {};
    snr_set = {};

    for j = 1:length(hyp_trans.paths)

        hyp_trans.string = fileread([hyp_trans.dir{i}, '/', hyp_trans.paths(j).name]);

        split_str = strsplit(hyp_trans.paths(j).name, '_');
        speaker = split_str{1};
        utterance = split_str{2}(1:end-4);

        ref_trans.string = fileread([ref_trans.dir, '/', speaker, '/', speaker, ...
            '_', utterance, '.txt']);
        ref_trans.string = regexp(ref_trans.string, '\n', 'split');
        ref_trans.string = lower(ref_trans.string{1});
        ref_trans.string = strrep(ref_trans.string,'.','');

        wer = WER(strtrim(hyp_trans.string), strtrim(ref_trans.string));

        results = [results, wer(1)];

        clc;
        fprintf('%.2f%%\n', 100*j/length(hyp_trans.paths));
    end

    fileID = fopen([res_dir, '/', ver, '.csv'],'w');
    fprintf(fileID, 'noise_src, snr_db, wer\n');

    save([res_dir, '/', ver, '.mat'], 'results');

    avg_path = [res_dir, '/average.csv'];

    if ~exist(avg_path, 'file')
        fileID = fopen(avg_path, 'w');
        fprintf(fileID, 'ver, WER\n');
        fclose(fileID);
    end

    fileID = fopen(avg_path, 'a');
    fprintf(fileID, '%s, %.2f\n', ver, 100*mean(results));
    fclose(fileID);
end
% EOF

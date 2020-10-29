% AUTHOR:         Aaron Nicolson
% AFFILIATION:    Signal Processing Laboratory, Griffith University
%
% This Source Code Form is subject to the terms of the Mozilla Public
% License, v. 2.0. If a copy of the MPL was not distributed with this
% file, You can obtain one at http://mozilla.org/MPL/2.0/.

clear all; close all; clc;
results_dir = 'res';
all_paths = dir([results_dir, '/*.mat']);
paths = {'irm_e125.mat';'irm_mse_e125.mat';'mag_norm_e125.mat'};


fprintf("Two-sample t-tests p-values:\n");
for i = 1:length(paths)
    for j = 1:length(paths)
        if j > i
            tgt1 = load([results_dir, '/', paths{i}], 'results');
            tgt1 = tgt1.results;
            tgt1_ver = strsplit(paths{i}, {'/', '.'});
            tgt1_ver = tgt1_ver{1};
            
            tgt2 = load([results_dir, '/', paths{j}], 'results');
            tgt2 = tgt2.results;
            tgt2_ver = strsplit(paths{j}, {'/', '.'});
            tgt2_ver = tgt2_ver{1};
            
            [~,p] = ttest2(tgt1, tgt2);
            fprintf("%.2f for WER %s vs. %s.",p , tgt1_ver, tgt2_ver);
            
            fprintf("\n");
        end
    end
end
% EOF

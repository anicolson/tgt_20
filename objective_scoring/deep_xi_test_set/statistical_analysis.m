% AUTHOR:         Aaron Nicolson
% AFFILIATION:    Signal Processing Laboratory, Griffith University
%
% This Source Code Form is subject to the terms of the Mozilla Public
% License, v. 2.0. If a copy of the MPL was not distributed with this
% file, You can obtain one at http://mozilla.org/MPL/2.0/.

clear all; close all; clc;
results_dir = 'results';
all_paths = dir('results/*.mat');
paths = {'xi_bar_e150_mmse-lsa.mat';'xi_bar_e150_srwf.mat';'xi_bar_mse_e150_mmse-lsa.mat';'xi_bar_mse_e150_srwf.mat'};

fprintf("Two-sample t-tests p-values:\n");
for i = 1:length(paths)
    for j = 1:length(paths)
        if j > i
            tgt1 = load([results_dir, '/', paths{i}], 'avg');
            tgt1 = tgt1.avg;
            tgt1_ver = strsplit(paths{i}, {'/', '.'});
            tgt1_ver = tgt1_ver{1};
            
            tgt2 = load([results_dir, '/', paths{j}], 'avg');
            tgt2 = tgt2.avg;
            tgt2_ver = strsplit(paths{j}, {'/', '.'});
            tgt2_ver = tgt2_ver{1};
            
            [~,p] = ttest2(tgt1.CSIG, tgt2.CSIG);
            fprintf("%.2f for CSIG %s vs. %s.\n",p , tgt1_ver, tgt2_ver);
            
            [~,p] = ttest2(tgt1.CBAK, tgt2.CBAK);
            fprintf("%.2f for CBAK %s vs. %s.\n",p , tgt1_ver, tgt2_ver);
            
            [~,p] = ttest2(tgt1.COVL, tgt2.COVL);
            fprintf("%.2f for COVL %s vs. %s.\n",p , tgt1_ver, tgt2_ver);
            
            [~,p] = ttest2(tgt1.PESQ, tgt2.PESQ);
            fprintf("%.2f for PESQ %s vs. %s.\n",p , tgt1_ver, tgt2_ver);
            
            [~,p] = ttest2(tgt1.SegSNR, tgt2.SegSNR);
            fprintf("%.2f for SegSNR %s vs. %s.\n",p , tgt1_ver, tgt2_ver);
            
            [~,p] = ttest2(tgt1.STOI, tgt2.STOI);
            fprintf("%.2f for STOI %s vs. %s.\n",p , tgt1_ver, tgt2_ver);
            
            fprintf("\n");
        end
    end
end
% EOF

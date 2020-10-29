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
results_dir = 'results';
all_paths = dir('results/*.mat');
paths = {'irm_demand_vb_e125.mat';'irm_mse_demand_vb_e125.mat';'mag_norm_demand_vb_e125.mat'};

diff = 1;
equal = 0;

vars.alpha = 0.05;
vars.theta = 0.05;
vars.percent_flag = 1;
vars.equal_var_flag = 0;
vars.plot_flag = 1;
vars.title_name = '';

if diff
    fprintf("Two-sample t-tests p-values:\n");
    for i = 1:length(paths)
        for j = 1:length(paths)
            if j > i
                tgt1 = load([results_dir, '/', paths{i}], 'S');
                tgt1 = tgt1.S;
                tgt1_ver = strsplit(paths{i}, {'/', '.'});
                tgt1_ver = tgt1_ver{1};

                tgt2 = load([results_dir, '/', paths{j}], 'S');
                tgt2 = tgt2.S;
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
end

if equal
    fprintf("TOST:\n");
    for i = 1:length(paths)
        for j = 1:length(paths)
            if j > i
                tgt1 = load([results_dir, '/', paths{i}], 'S');
                tgt1 = tgt1.S;
                tgt1_ver = strsplit(paths{i}, {'/', '.'});
                tgt1_ver = tgt1_ver{1};

                tgt2 = load([results_dir, '/', paths{j}], 'S');
                tgt2 = tgt2.S;
                tgt2_ver = strsplit(paths{j}, {'/', '.'});
                tgt2_ver = tgt2_ver{1};

                [H,p] = my_TOST(tgt1.CSIG, tgt2.CSIG, vars);
                fprintf("%d for CSIG %s vs. %s.\n", H, tgt1_ver, tgt2_ver);

                [H,p] = my_TOST(tgt1.CBAK, tgt2.CBAK, vars);
                fprintf("%d for CBAK %s vs. %s.\n", H, tgt1_ver, tgt2_ver);

                [H,p] = my_TOST(tgt1.COVL, tgt2.COVL, vars);
                fprintf("%d for COVL %s vs. %s.\n", H, tgt1_ver, tgt2_ver);

                [H,p] = my_TOST(tgt1.PESQ, tgt2.PESQ, vars);
                fprintf("%d for PESQ %s vs. %s.\n", H, tgt1_ver, tgt2_ver);

                [H,p] = my_TOST(tgt1.SegSNR, tgt2.SegSNR, vars);
                fprintf("%d for SegSNR %s vs. %s.\n", H, tgt1_ver, tgt2_ver);

                [H,p] = my_TOST(tgt1.STOI, tgt2.STOI, vars);
                fprintf("%d for STOI %s vs. %s.\n", H, tgt1_ver, tgt2_ver);

                fprintf("\n");
            end
        end
    end
end

% EOF

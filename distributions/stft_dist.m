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

% addpath('D:\Dropbox\lib\addnoise')
% addpath('D:\Dropbox\GitHub\matlab_feat\feat')

% addpath('C:\Users\aaron\Dropbox\lib\addnoise')
% addpath('C:\Users\aaron\Dropbox\GitHub\matlab_feat\feat')

addpath('~/Dropbox/lib/addnoise')
addpath('~/Dropbox/GitHub/matlab_feat/feat')

% % addpath(genpath('C:\Users\aaron\Dropbox\GitHub\DeepXi\dev'))

%% PARAMETERS
rng(43)
n_samples = 1000; % number of samples to consider.
T_d = 32; % window duration (ms).
T_s = 16; % window shift (ms).
f_s = 16000; % sampling frequency (Hz).
SNR = [-10 -5 0 5 10 15 20]; % SNR dB level.
s.N_d = round(f_s*T_d*0.001); % window duration (samples).
s.N_s = round(f_s*T_s*0.001); % window shift (samples).
s.f_s = f_s; % sampling frequency (Hz).
s.NFFT = 2^nextpow2(s.N_d); % frequency bins (samples).
x = s; d = s; y = s;

%% PATHS

% s.paths = dir('D:\set\deep_xi_training_set\train_clean_speech\*.wav');
% d.paths = dir('D:\set\deep_xi_training_set\train_noise\*.wav');

% s.paths = dir('C:\Users\aaron\Desktop\deep_xi_test_set\test_clean_speech\*.wav');
% d.paths = dir('C:\Users\aaron\Desktop\deep_xi_test_set\test_noise\*.wav');

s.paths = dir('~/set/deep_xi_training_set/train_clean_speech/*.wav');
d.paths = dir('~/set/deep_xi_training_set/train_noise/*.wav');

rand_idx = randperm(length(s.paths)); % random index for test files.

%% SAMPLE
set(0,'defaulttextinterpreter','latex')
xi_samples = [];
gamma_samples = [];
s_stms_samples = [];
for i = 1:n_samples
	s.wav = audioread([s.paths(rand_idx(i)).folder, '/', s.paths(rand_idx(i)).name]); % clean speech.
    s.len = length(s.wav); % length of clean speech signal.
    len_flag = true; % flag used to ensure length of noise signal is longer than clean speech signal length.
    while len_flag
        d.idx = randi(length(d.paths)); % random noise signal.
        d.src = audioread([d.paths(d.idx).folder, '/', d.paths(d.idx).name]); % noise.
        d.len = length(d.src); % length of noise signal.
        if d.len > s.len
            len_flag = false; % length of noise signal is longer than clean speech signal length.
        end
    end
    d.start_idx = randi(1+d.len-s.len); % random starting index of noise signal.
    d.src = d.src(d.start_idx:d.start_idx+s.len-1); % extract random section of noise signal.
    j = randperm(length(SNR),1);
    [x.wav, d.wav] = add_noise(s.wav, d.src(1:length(s.wav)), SNR(j)); % noisy speech and noise signal.
    s = analysis_stft(s, 'polar'); % clean speech STMS.
    d = analysis_stft(d, 'polar'); % noise STMS.
    x = analysis_stft(x, 'polar'); % noisy speech STMS.
    xi = s.STMS.^2./d.STMS.^2; % instantaneous a priori SNR.
    gamma_ = x.STMS.^2./d.STMS.^2; % instantaneous a posteriori SNR.

    xi_samples = [xi_samples; single(xi)];
    gamma_samples = [gamma_samples; single(gamma_)];
    s_stms_samples = [s_stms_samples; single(s.STMS)];

    clc;
    fprintf('%3.2f%% completed.\n', 100*(i/n_samples));
end

%% SAMPLES FOR K'TH FREQUENCY COMPONENT
grey = [0.4,0.4,0.4];
N = 500;
k = 65; % frequency bin to consider.

xi = -0.2:0.1:10;
xi_samples_k = xi_samples(:,k);

xi_db = -110:0.1:90; % instantaneous a priori SNR in dB.
xi_db_samples_k = 10*log10(xi_samples_k + 1e-12);
xi_db_samples_k(xi_db_samples_k == Inf) = [];

gamma_ = -0.2:0.1:10;
gamma_samples_k = gamma_samples(:,k);
gamma_samples_k(gamma_samples_k == Inf) = [];

gamma_db = -5:0.5:15;
gamma_db_samples_k = double(10*log10(gamma_samples_k + 1e-12));
gamma_db_samples_k(gamma_db_samples_k == Inf) = [];
gamma_l = 0.0;
gamma_u = [10^(10/10), 10^(20/10), 10^(30/10), 10^(40/10)];

s_stms = -0.2:0.1:10;
s_stms_samples_k = s_stms_samples(:,k);

s_stms_db = -110:0.1:40;
s_stms_db_samples_k = 20*log10(s_stms_samples_k + 1e-12);
s_stms_db_samples_k(s_stms_db_samples_k == Inf) = [];

%% HISTOGRAMS
figure (1)

subplot(3,2,1);
histogram(s_stms_db_samples_k, N, 'BinLimits', [s_stms_db(1), s_stms_db(end)], ...
    'EdgeAlpha', 0.0, 'FaceColor', grey);
xlim([s_stms_db(1), s_stms_db(end)])
ylabel('Count');
xlabel(['$|S_{\rm dB}[:,$', num2str(k-1), '$]|$']);
title('{\bf (a)}')

subplot(3,2,2);
histogram(s_stms_db_samples_k, N, 'BinLimits', [s_stms_db(1), s_stms_db(end)], ...
    'EdgeAlpha', 0.0, 'FaceColor', grey, 'Normalization', 'cdf');
xlim([s_stms_db(1), s_stms_db(end)])
ylim([0 1])
xlabel(['$|S_{\rm dB}[:,$', num2str(k-1), '$]|$']);
ylabel('Cumulative count');
title('{\bf (b)}')

subplot(3,2,3);
histogram(xi_db_samples_k, N, 'BinLimits', [xi_db(1), xi_db(end)], ...
    'EdgeAlpha', 0.0, 'FaceColor', grey);
xlim([xi_db(1), xi_db(end)])
ylabel('Count');
xlabel(['$\xi_{\rm dB}[:,$', num2str(k-1), ']']);
title('{\bf (c)}')

subplot(3,2,4);
histogram(xi_db_samples_k, N, 'BinLimits', [xi_db(1), xi_db(end)], ...
    'EdgeAlpha', 0.0, 'FaceColor', grey, 'Normalization', 'cdf');
xlim([xi_db(1), xi_db(end)])
ylim([0 1])
xlabel(['$\xi_{\rm dB}[:,$', num2str(k-1), ']']);
ylabel('Cumulative count');
title('{\bf (d)}')

subplot(3,2,5);
histogram(gamma_db_samples_k, N, 'BinLimits', [gamma_db(1), gamma_db(end)], ...
    'EdgeAlpha', 0.0, 'FaceColor', grey);
xlim([gamma_db(1), gamma_db(end)])
ylabel('Count');
xlabel(['$\gamma_{\rm dB}[:,$', num2str(k-1), ']']);
title('{\bf (e)}')

subplot(3,2,6);
histogram(gamma_db_samples_k, N, 'BinLimits', [gamma_db(1), gamma_db(end)], ...
    'EdgeAlpha', 0.0, 'FaceColor', grey, 'Normalization', 'cdf');
xlim([gamma_db(1), gamma_db(end)])
ylim([0 1])
xlabel(['$\gamma_{\rm dB}[:,$', num2str(k-1), ']']);
ylabel('Cumulative count');
title('{\bf (f)}')

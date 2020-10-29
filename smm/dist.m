%% AUTHOR:         Aaron Nicolson
%% AFFILIATION:    Signal Processing Laboratory, Griffith University
%%
%% This Source Code Form is subject to the terms of the Mozilla Public
%% License, v. 2.0. If a copy of the MPL was not distributed with this
%% file, You can obtain one at http://mozilla.org/MPL/2.0/.
clear all; close all; clc;

% addpath('D:\Dropbox\lib\addnoise')
% addpath('D:\Dropbox\GitHub\matlab_feat\feat')

% addpath('C:\Users\aaron\Dropbox\lib\addnoise')
% addpath('C:\Users\aaron\Dropbox\GitHub\matlab_feat\feat')

addpath('~/Dropbox/projects/matlab_feat/feat')

% % addpath(genpath('C:\Users\aaron\Dropbox\GitHub\DeepXi\dev'))

%% PARAMETERS
rng(43)
n_samples = 50; % number of samples to consider.
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
smm_samples = []; 
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
    
    smm = s.STMS./x.STMS; 
    
    smm_samples = [smm_samples; single(smm)]; 

    clc;
    fprintf('%3.2f%% completed.\n', 100*(i/n_samples));
end

%% SAMPLES FOR K'TH FREQUENCY COMPONENT
grey = [0.4,0.4,0.4];
N = 500;
k = 65; % frequency bin to consider.

smm = -0.2:0.1:10;
smm_samples_k = smm_samples(:,k);

smm_db = -50:0.1:50;
smm_db_samples_k = 20*log10(smm_samples_k);

%% HISTOGRAMS
figure (1)

subplot(2,2,1);  
histogram(smm_samples_k, N, 'BinLimits', [smm(1), smm(end)], ...
    'EdgeAlpha', 0.0, 'FaceColor', grey);
xlim([smm(1), smm(end)])
ylabel('Count');
xlabel(['${\rm SMM}[:,$', num2str(k-1), '$]$']); 
title('{\bf (a)}')

subplot(2,2,2);
histogram(smm_samples_k, N, 'BinLimits', [smm(1), smm(end)], ...
    'EdgeAlpha', 0.0, 'FaceColor', grey, 'Normalization', 'cdf');
xlim([smm(1), smm(end)])
ylim([0 1])
xlabel(['${\rm SMM}[:,$', num2str(k-1), '$]$']); 
ylabel('Cumulative count');
title('{\bf (b)}')

subplot(2,2,3);  
histogram(smm_db_samples_k, N, 'BinLimits', [smm_db(1), smm_db(end)], ...
    'EdgeAlpha', 0.0, 'FaceColor', grey);
xlim([smm_db(1), smm_db(end)])
ylabel('Count');
xlabel(['${\rm SMM}[:,$', num2str(k-1), '$]$']); 
title('{\bf (a)}')

subplot(2,2,4);
histogram(smm_db_samples_k, N, 'BinLimits', [smm_db(1), smm_db(end)], ...
    'EdgeAlpha', 0.0, 'FaceColor', grey, 'Normalization', 'cdf');
xlim([smm_db(1), smm_db(end)])
ylim([0 1])
xlabel(['${\rm SMM}[:,$', num2str(k-1), '$]$']); 
ylabel('Cumulative count');
title('{\bf (b)}')


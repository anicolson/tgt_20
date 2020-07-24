%% AUTHOR:         Aaron Nicolson
%% AFFILIATION:    Signal Processing Laboratory, Griffith University
%%
%% This Source Code Form is subject to the terms of the Mozilla Public
%% License, v. 2.0. If a copy of the MPL was not distributed with this
%% file, You can obtain one at http://mozilla.org/MPL/2.0/.
clear all; close all; clc;

addpath('D:\Dropbox\lib\addnoise')
addpath('D:\Dropbox\GitHub\matlab_feat\feat')

% addpath('C:\Users\aaron\Dropbox\lib\addnoise')
% addpath('C:\Users\aaron\Dropbox\GitHub\matlab_feat\feat')
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

s.paths = dir('D:\set\deep_xi_training_set\train_clean_speech\*.wav');
d.paths = dir('D:\set\deep_xi_training_set\train_noise\*.wav');

% s.paths = dir('C:\Users\aaron\Desktop\deep_xi_test_set\test_clean_speech\*.wav');
% d.paths = dir('C:\Users\aaron\Desktop\deep_xi_test_set\test_noise\*.wav');

rand_idx = randperm(length(s.paths)); % random index for test files.

%% SAMPLE
set(0,'defaulttextinterpreter','latex')
xi_samples = []; 
gamma_samples = [];
s_stms_samples = [];
lsa_samples = [];
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
    G_mmse_lsa = gfunc(xi, gamma_, 'mmse-lsa');
    
    xi_samples = [xi_samples; single(xi)]; 
    gamma_samples = [gamma_samples; single(gamma_)];  
    s_stms_samples = [s_stms_samples; single(s.STMS)]; 
    lsa_samples = [lsa_samples; single(G_mmse_lsa)]; 

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

%%
lsa = -0.2:0.1:10;
lsa_samples_k = lsa_samples(:,k);
lsa_db = -110:0.1:40;
lsa_db_samples_k = 20*log10(lsa_samples_k + 1e-12);


%% HISTOGRAMS
figure (1)

subplot(6,2,1);
histogram(xi_samples_k, N, 'BinLimits', [xi(1), xi(end)], ...
    'EdgeAlpha', 0.0, 'FaceColor', grey);
xlim([xi(1), xi(end)])
xlabel(['$\xi[:,$', num2str(k-1), ']']); 
ylabel('Count');

subplot(6,2,2);
histogram(xi_samples_k, N, 'BinLimits', [xi(1), xi(end)], ...
    'EdgeAlpha', 0.0, 'FaceColor', grey, 'Normalization', 'cdf');
xlim([xi(1), xi(end)])
ylim([0 1])
xlabel(['$\xi[:,$', num2str(k-1), ']']); 
ylabel('Normalised cumulative count');

subplot(6,2,3);
histogram(xi_db_samples_k, N, 'BinLimits', [xi_db(1), xi_db(end)], ...
    'EdgeAlpha', 0.0, 'FaceColor', grey);
xlim([xi_db(1), xi_db(end)])
ylabel('Count');
xlabel(['$\xi_{\rm dB}[:,$', num2str(k-1), ']']); 

subplot(6,2,4);
histogram(xi_db_samples_k, N, 'BinLimits', [xi_db(1), xi_db(end)], ...
    'EdgeAlpha', 0.0, 'FaceColor', grey, 'Normalization', 'cdf');
xlim([xi_db(1), xi_db(end)])
ylim([0 1])
xlabel(['$\xi_{\rm dB}[:,$', num2str(k-1), ']']); 
ylabel('Normalised cumulative count');

subplot(6,2,5);
histogram(gamma_samples_k, N, 'BinLimits', [gamma_(1), gamma_(end)], ...
    'EdgeAlpha', 0.0, 'FaceColor', grey);
xlim([gamma_(1), gamma_(end)])
xlabel(['$\gamma[:,$', num2str(k-1), ']']); 
ylabel('Count');

subplot(6,2,6);
histogram(gamma_samples_k, N, 'BinLimits', [gamma_(1), gamma_(end)], ...
    'EdgeAlpha', 0.0, 'FaceColor', grey, 'Normalization', 'cdf');
xlim([gamma_(1), gamma_(end)])
ylim([0 1])
xlabel(['$\gamma[:,$', num2str(k-1), ']']); 
ylabel('Normalised cumulative count');

subplot(6,2,7);
histogram(gamma_db_samples_k, N, 'BinLimits', [gamma_db(1), gamma_db(end)], ...
    'EdgeAlpha', 0.0, 'FaceColor', grey);
xlim([gamma_db(1), gamma_db(end)])
ylabel('Count');
xlabel(['$\gamma_{\rm dB}[:,$', num2str(k-1), ']']); 

subplot(6,2,8);
histogram(gamma_db_samples_k, N, 'BinLimits', [gamma_db(1), gamma_db(end)], ...
    'EdgeAlpha', 0.0, 'FaceColor', grey, 'Normalization', 'cdf');
xlim([gamma_db(1), gamma_db(end)])
ylim([0 1])
xlabel(['$\gamma_{\rm dB}[:,$', num2str(k-1), ']']); 
ylabel('Normalised cumulative count');

subplot(6,2,9);
histogram(s_stms_samples_k, N, 'BinLimits', [s_stms(1), s_stms(end)], ...
    'EdgeAlpha', 0.0, 'FaceColor', grey);
xlim([s_stms(1), s_stms(end)])
xlabel(['$|S[:,$', num2str(k-1), '$]|$']); 
ylabel('Count');

subplot(6,2,10);
histogram(s_stms_samples_k, N, 'BinLimits', [s_stms(1), s_stms(end)], ...
    'EdgeAlpha', 0.0, 'FaceColor', grey, 'Normalization', 'cdf');
xlim([s_stms(1), s_stms(end)])
ylim([0 1])
xlabel(['$|S[:,$', num2str(k-1), '$]|$']); 
ylabel('Normalised cumulative count');

subplot(6,2,11);
histogram(s_stms_db_samples_k, N, 'BinLimits', [s_stms_db(1), s_stms_db(end)], ...
    'EdgeAlpha', 0.0, 'FaceColor', grey);
xlim([s_stms_db(1), s_stms_db(end)])
ylabel('Count');
xlabel(['$|S[:,$', num2str(k-1), '$]|$ (dB)']); 

subplot(6,2,12);
histogram(s_stms_db_samples_k, N, 'BinLimits', [s_stms_db(1), s_stms_db(end)], ...
    'EdgeAlpha', 0.0, 'FaceColor', grey, 'Normalization', 'cdf');
xlim([s_stms_db(1), s_stms_db(end)])
ylim([0 1])
xlabel(['$|S[:,$', num2str(k-1), '$]|$ (dB)']); 
ylabel('Normalised cumulative count');

%% HISTOGRAMS
figure (2)

subplot(2,2,1);
histogram(lsa_samples_k, N, 'BinLimits', [lsa(1), lsa(end)], ...
    'EdgeAlpha', 0.0, 'FaceColor', grey);
xlim([lsa(1), lsa(end)])
xlabel(['$G_{\rm MMSE-LSA}[:,$', num2str(k-1), ']']); 
ylabel('Count');

subplot(2,2,2);
histogram(lsa_samples_k, N, 'BinLimits', [xi(1), xi(end)], ...
    'EdgeAlpha', 0.0, 'FaceColor', grey, 'Normalization', 'cdf');
xlim([xi(1), xi(end)])
ylim([0 1])
xlabel(['$G_{\rm MMSE-LSA}[:,$', num2str(k-1), ']']); 
ylabel('Normalised cumulative count');

subplot(2,2,3);
histogram(lsa_db_samples_k, N, 'BinLimits', [lsa_db(1), lsa_db(end)], ...
    'EdgeAlpha', 0.0, 'FaceColor', grey);
xlim([lsa_db(1), lsa_db(end)])
ylabel('Count');
xlabel(['$G_{\rm MMSE-LSA}[:,$', num2str(k-1), '] (dB)']); 

subplot(2,2,4);
histogram(lsa_db_samples_k, N, 'BinLimits', [lsa_db(1), lsa_db(end)], ...
    'EdgeAlpha', 0.0, 'FaceColor', grey, 'Normalization', 'cdf');
xlim([lsa_db(1), lsa_db(end)])
ylim([0 1])
xlabel(['$G_{\rm MMSE-LSA}[:,$', num2str(k-1), '] (dB)']); 
ylabel('Normalised cumulative count');

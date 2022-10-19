%% The processing order
%
% 1. Define parameters
% 2. Load the data
% 3. Filter the data
% 4. (Optional) Dominance Fraction & Life time Parameters
% 5. Compute Number of Transitions
% 6. Transition Correction for KL Entropy Calculation
% 7. Compute Individual KL Entropy
% 8. Compute Group KL Entropy

%% 1. Define parameters

% clear all
% clc

% no_clust=12; % number of clusters
filterwindows=3; % minimum duration of brain states
filterLEIDA = 0; % if you want to calculate individual filtered LEIDAs make this '1'

%% 2. Load the data

% load (strcat('Analyze_Data',num2str(no_clust),'clust.mat'));


load (strcat('Analyze_Data',num2str(no_clust),'clust_new.mat'));


%% 3. Filter the data

Data = lei_transitionfilter(Data,filterwindows, filterLEIDA);

%% 4. (Optional) Dominance Fraction & Life time Parameters

Data = lei_dominancefraction(Data);

Data = lei_lifetime(Data);

 %% 5. Compute Number of Transitions

Data = lei_transitions(Data);

%% 6. Transition Correction for KL Entropy Calculation

Data = lei_transitioncorrection_for_klentropy(Data);

%% 7. Compute Individual KL Entropy

Data = lei_indiv_kl_entropy(Data);

%% 8. Compute Group KL Entropy

GrEnt = lei_gr_kl_entropy(Data);

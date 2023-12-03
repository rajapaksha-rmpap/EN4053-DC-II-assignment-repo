% -------------------------- Arithmetic Coding ---------------------------

% clc; clear;

global symbols  probs  CDF;

symbols = 0:9; % source symbols
probs = [0.1 0.1 0.05 0.05 0.2 0.1 0.05 0.05 0.05 0.25]; % probablities of the source symbols in order

% finding the CDF of the probabllity distribution
CDF = zeros(1, numel(probs)+1);
cumulative_prob = 0;
for i = 1:length(probs)
    cumulative_prob = cumulative_prob + probs(i);
    CDF(i+1) = cumulative_prob;
end

index_number = '190484'; % sequence to decode, as a char array

% finding the arithmetic code
fprintf("\n--------------- Arithmetic Coding ---------------\n\n");
arithmetic_encoder(index_number);

% finding the arithmetic code using incremental encoding
fprintf("\n--------- Incremental Arithmetic Coding ---------\n\n");
incremental_arithmetic_encoder(index_number);

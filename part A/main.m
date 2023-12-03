global CODE

% question 1 - example given in the assignment
sig = [1, 2, 3]; % alphabet/array of symbols
p = [0.4, 0.5, 0.1];   % array of probabilities

huffman(sig, p);


% question 3- generating Huffman code for the english alphabet
letters = 'a':'z'; % an array of english letters
p = [8.160, 1.492, 2.782, 4.153, 13.004, ...
     2.228, 2.015, 6.094, 6.966,  0.153, ...
     0.778, 4.025, 2.406, 6.749,  7.507, ...
     1.929, 0.095, 5.787, 6.327,  9.056, ...
     2.758, 0.978, 2.360, 0.150,  1.974, ...
     0.074]; % probabilities of each lettter given as percentages

huffman(letters, p);

% finding the entropy of the alphabet and the avg. code length
p = p/100; % convert the probabilities given in percenteages into ratios
entropy = 0;
L = 0; 
for x = 1:length(letters)
    % finding the entropy
    entropy = entropy - p(x) * log2(p(x));
    
    % finding the avg. codeword length
    code_x = CODE(letters(x));
    L = L + p(x) * length(code_x{1});
end 

fprintf("Entropy of the source: %.3f bits/symbol\n", entropy);
fprintf("Avg. codeword length : %.3f bits/symbol\n"  , L);

% question 4 - encoding the last name with the obtained Huffman code for the alphabet
last_name = 'rajapaksha';
result = [];
for char = last_name
    code = CODE(char);
    result = [result code{1}];
end

fprintf("\nname: %s -> \ncoded: %s", last_name, num2str(result))

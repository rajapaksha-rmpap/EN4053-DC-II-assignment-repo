% The code snippet given in the assignment as an example...
% Here, I have made some slight changes to make the code more meaningful.

sig = [1, 2, 3]; % alphabet/array of symbols
p = [0.4, 0.5, 0.1]; % array of probabilities

global CODE
CODE = dictionary();

% convert the alphabet array to a cell array
s = num2cell(sig);

% sort the probabilities in the increasing order
[p, i] = sort(p);

% reorder the alphabet array according to the sorted probabilities
s = s(i);

% creating a new symbol by combining the two symbols with the lowest probabilities
s{2} = {s{1}, s{2}};
s(1) = [];
p(2) = p(1) + p(2);
p(1) = [];

% finding the Huffman codes for the symbols
makecode(s, [])

display_CODE(sig);

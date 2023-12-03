%{
///////////////////////////////// huffman /////////////////////////////////
    - Generates the binary Huffman codes for the symbols of a given discrete 
    source.
    - When two symbols given, the symbol with the highest probability will be
    assigned a code 0, and the symbol with the lowest probability will be assigned 1.

    inputs:
        :param sig: an array representing the source symbols/syllabels
        :param p: an array containing the probabilities of each symbol in order 
    outputs:
        - No outputs get returned.
        - The Huffman (binary) codes for each symbol will be displayed in order as
        they appear in the `sig` array.
%}

function huffman(sig, p)
    
    global CODE
    CODE = dictionary();
    
    % convert the alphabet array to a cell array
    s = num2cell(sig);
    
    while length(s) > 2
    
        % sort the probabilities in the increasing order
        [p, i] = sort(p);
        
        % reorder the alphabet array according to the sorted probabilities
        s = s(i);
        
        % creating a new symbol by combining the two symbols with the lowest probabilities
        s{2} = {s{1}, s{2}};
        s(1) = [];
        p(2) = p(1) + p(2);
        p(1) = [];
    
    end
    
    % sort the probability array one more time
    [~, i] = sort(p);
    s = s(i);
    
    % finding the Huffman codes for the symbols
    makecode(s, [])
    
    % display the generated Huffman codes 
    display_CODE(sig);
    fprintf('\n');

end
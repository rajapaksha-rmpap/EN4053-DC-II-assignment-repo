%{
////////////////////////////// lzw_encoding ///////////////////////////////
    Encodes a character string according to the LZW dictionary coding
    
    inputs:
        :param input: the character string to encode
        :param dict: static dictionary containing all the single characters
    outputs:
        - returns the index sequence the input string is encoded into and
        the updated dictionary with the newly added entries
        - also, displays the intermediate steps, the encoded index sequence, 
        and the updated dictionary entries 
%}

function [index_seq, dict] = lzw_encoding(input, dict)

    index_seq = [];

    % let's append a stop code ('#') symbol to the input sequence 
    input = [input '#'];

    % initialize a string with the first character of the input sequence
    string = input(1); 
    
    i = 2;

    while true

        while dict.isKey([string input(i)])
            string = [string input(i)];
            i = i + 1;
        end
    
        % transmit the index of the match (append the index to index sequence)
        output_index = dict(string);
        index_seq = [index_seq output_index];

        fprintf("string: %s -> index: %i\n", string, output_index);
        
        % if the end of the input sequence is reached, stop encoding
        if input(i) == '#' 
            break
        end

        % add a new entry to the dictionary at the next available index
        dict([string input(i)]) = dict.numEntries+1;
    
        % reset the string 
        string = input(i);
        i = i + 1;

    end 
    
    % display the encoded index sequence
    fprintf("\noutput index sequence: %s \n", num2str(index_seq));

    % display the updated dictionary
    swapped_dict = dictionary();
    for key = dict.keys
        swapped_dict(dict(key)) = key;
    end
    fprintf("\nupdated dictionary at the encoder: \n");
    disp(swapped_dict);

end
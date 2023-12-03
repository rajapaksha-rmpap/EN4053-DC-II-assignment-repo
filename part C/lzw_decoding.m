%{
////////////////////////////// lzw_decoding ///////////////////////////////
    Decodes an index sequence which is encoded by the LZW dictionary coding 
    and obtains the transmitted character string 
    
    inputs:
        :param index_seq: the index sequence to decode
        :param dict: static dictionary containing all the single characters
    outputs:
        - returns the decoded output string and the updated dictionary with
        the newly added entries
        - also, displays the intermediate steps, the final decoded string, 
        and the updated dictionary entries 
%}

function [output, dict] = lzw_decoding(index_seq, dict)

    prev_index = index_seq(1);
    
    % initialize a variable to represent the output of the decoder
    fprintf("index: %i -> string: %s\n", prev_index, dict(prev_index));
    output = char(dict(prev_index));

    for i = 2:length(index_seq)

        curr_index = index_seq(i);

        entry = char(dict(prev_index));

        if dict.isKey(curr_index)
            string = char(dict(curr_index));
            entry = [entry string(1)];
        else
            entry = [entry entry(1)];
        end
        
        % add a new entry to the dictionary at the next available index
        dict(dict.numEntries+1) = entry;

        % release the string corresponding to the current index to the output 
        fprintf("index: %i -> string: %s\n", curr_index, dict(curr_index));
        output = [output char(dict(curr_index))];

        prev_index = curr_index;

    end

    % displaying the results: output string and the updated dictionary
    fprintf("\ndecoded string: %s \n", output);
    fprintf("\nupdated dictionary at the decoder: \n");
    disp(dict);

end
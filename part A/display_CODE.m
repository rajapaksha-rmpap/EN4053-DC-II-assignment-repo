%{
////////////////////////////// display_CODE //////////////////////////////
    Displays the syllabels and their assigned Huffman binary strings stored 
    in the globar variable, CODE, a dictionary. 

    inputs:
        :param sig: an array representing the source symbols/syllabels
    outputs:
        - No outputs are returned.
%}

function display_CODE(sig)

    global CODE

    for key = sig
        code = CODE(key);
        code = code{1};
        fprintf("%s -> %s\n", num2str(key), num2str(code));
    end

end
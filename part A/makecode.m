%{
/////////////////////////////////// makecode ///////////////////////////////////
    Assigns the Huffman binary strings to the syllabels given in a cell array.

    inputs:
        :param s: an array of cells of length 1 or 2
        :param code: the binary code assigned to the provided cell array, s
    outputs:
        - No outputs get returned.
        - The function will access the global CODE variable, which is assumed 
          to be a dictionary (a new data structure introduced in MATLAB R2022b),
          and will create an entry with the syllabel/symbol as the key and the 
          assigned Haffman code as the value. 
%}

function makecode(s, code)

    global CODE

    if length(s) == 1
        % assign the provided binary code to the symbol, s
        CODE(s) = {code};
    
    elseif length(s) == 2
        % assign 1 to the first cell block and recursively call the function 
        code1 = [code, 1];
        makecode(s{1}, code1);

        % assign 0 to the second cell block and recursively call the function 
        code2 = [code, 0];
        makecode(s{2}, code2);
    end

end
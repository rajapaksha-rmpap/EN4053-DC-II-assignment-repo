
%{
//////////////////////////// arithmetic_encoder ///////////////////////////
    - Assigns (binary) Arithmetic Codes for the digits/digit sequences
    according to the CDF of the given digits (must have been declared as a 
    global array). 

    inputs:
    :param data: the digit or the digit sequence to encode; must be a char 
    array. 

    outputs:
    - returns the tag value and the assigned binary arithmetic code
%}

function [tag, code] = arithmetic_encoder(data)

    global probs CDF

    % setting the initial lower and upper limits
    lower = 0;
    upper = 1; 

    for i = 1:length(data)
        % find the index for the symbol (digit)
        digit = data(i);
        j = str2num(digit)+2;

        % find the lower and upper limits for the next iteration
        lower_ = lower + (upper - lower) * CDF(j-1);
        upper_ = lower + (upper - lower) * CDF(j);

        % update the limits
        lower = lower_;
        upper = upper_;

        % display the intermediate results
        fprintf("for the sequence '%s': \n", data(1:i));
        fprintf("\tlower = %.15g\n", lower);
        fprintf("\tupper = %.15g\n", upper)
    end

    % calculate the tag value of the encoded data
    tag = (lower + upper)/2;
    fprintf("\ntag: %.15g \n", tag);

    % find the probability of the digit/digit sequence
    p = 1;
    for i = 1:length(data)
        p = p * probs(str2num(data(i))+1);
    end
    fprintf("probability of the symbol/sequence: %.15g \n", p);

    % codeword length 
    l = ceil(log2(1/p)) + 1;
    fprintf("codeword length: %d bits\n", l);

    % construct the codeword
    shifted_tag = tag * 2^l; % multiply the tag by 2^code_length
    code = dec2bin(shifted_tag);
    % append leading zeros to achieve the calculated length
    code = [repmat('0', 1, l-length(code)) code]; 
    fprintf("codeword: %s \n", code);

end

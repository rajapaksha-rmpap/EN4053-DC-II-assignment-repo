function [tag, code] = incremental_arithmetic_encoder(data)

    global probs CDF

    % find the codeword length in number of bits
    p = 1;
    for i = 1:length(data)
        p = p * probs(str2double(data(i))+1);
    end
    l = ceil(log2(1/p)) + 1;
    fprintf("required codeword length: %d bits\n", l);

    % setting the initial lower and upper limits
    lower = 0; upper = 1; 

    code = '';
    i = 1;

    while i <= length(data)
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
        fprintf("\tlower = %.10g\n\tupper = %.10g\n\t", lower, upper);

        % loop until the tag range is not completely confined within either the lower or upper halves
        while upper < 0.5 || lower > 0.5
            fprintf(" -> ")
            % if confined within the lower half, perform E1 conversion
            if upper < 0.5
                lower = 2*lower; upper = 2*upper;
                code = [code '0'];
                fprintf("(E1)");
            % if confined within the upper half, perform E2 conversion
            elseif lower > 0.5
                lower = 2*lower-1; upper = 2*upper-1;
                code = [code '1'];
                fprintf("(E2)");
            end
            fprintf("(%.10g, %.10g)", lower, upper);
        end
        fprintf("\n");
        i = i + 1;
    end
    % take a tag value within the final lower and upper bounds
    tag = (lower + upper)/2;
    % convert it to binary, truncate it to achieve the target code length, and append it to the code
    shifted_tag = tag * 2^(l-length(code));
    tail_code = dec2bin(shifted_tag);
    tail_code = [repmat('0', 1, l-length(code)-length(tail_code)) tail_code]; 
    code = [code tail_code];
    fprintf("\ncodeword: %s \n", code);
end

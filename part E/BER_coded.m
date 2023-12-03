%{
/////////////////////////////// coded_BER ////////////////////////////////
    - Returns the theoretical variation of the BER of an error correction
    scheme. 

    inputs:
        :param Eb_N0_in_dB: an array containing the Eb/N0 values given in dB
        :param n: codeword length
        :param k: dataword length
        :param t: maximum number of bit errors correctable
    outputs:
        - returns the array of theoretical BER values for the given Eb/N0
        values
%}

function [BER_arr] = BER_coded(Eb_N0_in_dB, n, k, t)

    Eb_N0 = 10.^(Eb_N0_in_dB/10); % converting Eb/N0 given in dB to ratios
    P_bc = qfunc(sqrt(2*(k/n)*Eb_N0));
    
    BER_arr = zeros(1, length(Eb_N0_in_dB));
    for j = t+1:n
        BER_arr = BER_arr + nchoosek(n-1, j-1) * P_bc.^j .* (1-P_bc).^(n-j);
    end

    BER_arr = (n-1) * P_bc.^2;
    
end
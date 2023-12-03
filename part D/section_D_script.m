clear;
clc;

% configuring the simulation parameter
model = gcs;
stop_time = 1e8;
set_param(model, 'StopTime', num2str(stop_time));

% creating array for the Eb/N0 values 
Eb_N0_arr = -4:2:12;

AWGN_variance = 0.1; % in W
N0 = 2 * AWGN_variance; % noise power

fprintf("******* Uncoded System *******\n\n");

BER_arr = zeros(1, length(Eb_N0_arr));
for i = 1:numel(Eb_N0_arr)
    
    % set the Eb/N0 (in dB) value
    Eb_N0_in_dB = Eb_N0_arr(i);

    % finding the transmit power values
    Eb_N0 = 10^(Eb_N0_in_dB/10);
    Pt = Eb_N0 * N0;

    % run the simulink model
    sim("section_D.slx");
    
    % store the BER values observed
    BER_arr(i) = ErrorVec(1);
    fprintf('Eb/N0 = %d dB -> Pt = %f, BER = %f \n', Eb_N0_in_dB, Pt, ErrorVec(1));
    disp(num2str(ErrorVec));
    
end

% storing the results
save("BER_arr.mat", "BER_arr", "-double");

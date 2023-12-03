% configuring the simulation parameters
model = gcs;
stop_time = 1e8;
set_param(model, 'StopTime', num2str(stop_time));

% initializing the graph plot
figure;
colors = ["b", "g"];
legend_labels = cell(1, 3);

% creating array for the Eb/N0 values 
Eb_N0_arr = -4:2:10; 

% loading and plotting the data for the uncoded system
uncoded_system = load("../sim_model/BER_arr.mat"); % change the path accordingly
semilogy(Eb_N0_arr, uncoded_system.BER_arr(1:numel(Eb_N0_arr)), "red", 'LineWidth', 1.5);
hold on;
legend_labels{1} = "uncoded";

% simulating the Hamming coded systems
ns = [7, 15];
ks = [4, 11];

BER_arr = zeros(2, numel(Eb_N0_arr));

for i = 1:2

    n = ns(i);
    k = ks(i);
    
    fprintf("\n******* Hamming Code - (%d, %d) *******\n\n", n, k);

    for j = 1:numel(Eb_N0_arr)
        
        % set the Eb/N0 (in dB) value in the AWGN channel
        % the value must correspond to (k/n) times the uncoded Eb/N0 ratio as proved in the report
        uncoded_Eb_N0_in_dB = Eb_N0_arr(j);
        Eb_N0_in_dB = uncoded_Eb_N0_in_dB + 10*log10(k/n);
    
        % run the simulink model
        sim(model);
        
        % store the BER values observed
        BER_arr(i, j) = ErrorVec(1);
        
        fprintf('Eb/N0 = %d dB -> BER = %f \n', uncoded_Eb_N0_in_dB, ErrorVec(1));
        disp(num2str(ErrorVec));
        
    end

    % plotting the results
    BER_arr_ = BER_arr(i, :);
    lineSpec = colors(i);
    semilogy(Eb_N0_arr, BER_arr_, lineSpec, 'LineWidth', 1.5); hold on;
    legend_labels{i+1} = "(n, k) = (" + num2str(n) + ", " + num2str(k) + ")";

end

hold off;
title("BER vs Eb/N0");
xlabel("Eb/N0 (dB)");
ylabel("BER (bits/sec)");
legend(legend_labels);

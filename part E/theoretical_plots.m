
% plotting the theoretical BER variations for the uncoded and coded systems
Eb_N0_in_dB = -4:0.1:10;
Eb_N0 = 10.^(Eb_N0_in_dB/10); % converting Eb/N0 given in dB to ratios

% BER for the uncoded system
BERu = qfunc(sqrt(2*Eb_N0));
% BER for the coded systems
BERc1 = BER_coded(Eb_N0_in_dB,  7,  4, 1); % for (7, 4) Hamming code
BERc2 = BER_coded(Eb_N0_in_dB, 15, 11, 1); % for (15, 11) Hamming code

figure
legend_labels = cell(1, 3);

semilogy(Eb_N0_in_dB, BERu, 'r', 'LineWidth', 1.5);
legend_labels{1} = "thoretical uncoded";
hold on;

semilogy(Eb_N0_in_dB, BERc1, 'b', 'LineWidth', 1.5);
legend_labels{2} = "thoretical coded - (7, 4)";
hold on;

semilogy(Eb_N0_in_dB, BERc2, 'g', 'LineWidth', 1.5);
legend_labels{3} = "thoretical coded - (15, 11)";

xlabel("Eb/N0 (dB)");
ylabel("BER (bits/sec)");
title("Theoretical Variations of BER vs. Eb/N0");
legend(legend_labels);
hold off;

% plotting the observed results along with the theoretical estimations
Eb_N0_arr = -4:2:10;
figure;

legend_labels = cell(1, 6);

semilogy(Eb_N0_arr, uncoded_system.BER_arr(1:numel(Eb_N0_arr)), "r", 'LineWidth', 1.5);
legend_labels{1} = "uncoded";
hold on;

BER_arr_ = BER_arr(1, :);
semilogy(Eb_N0_arr, BER_arr_, 'b', 'LineWidth', 1.5); 
legend_labels{2} = "coded - (7, 4)";
hold on;

BER_arr_ = BER_arr(2, :);
semilogy(Eb_N0_arr, BER_arr_, 'g', 'LineWidth', 1.5); 
legend_labels{3} = "coded - (15, 11)";
hold on;


semilogy(Eb_N0_in_dB, BERu, '--k', 'LineWidth', 1);
legend_labels{4} = "thoretical uncoded";
hold on;

semilogy(Eb_N0_in_dB, BERc1, '--b', 'LineWidth', 1);
legend_labels{5} = "thoretical coded - (7, 4)";
hold on;

semilogy(Eb_N0_in_dB, BERc2, '--g', 'LineWidth', 1);
legend_labels{6} = "thoretical coded - (15, 11)";

xlabel("Eb/N0 (dB)");
ylabel("BER (bits/sec)");
title("Observed and Theoretical Variations of BER vs. Eb/N0");
legend(legend_labels);
hold off;

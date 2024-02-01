%% Function for image equalization

function [floored, equalized] = f_equalization (img, m)
    % Get image dimensions
    [M, N] = size(img);
    
    %% Calculate Histogram
    img_histogram = f_histogram(img);
    
    %% Calculate Normalized Histogram (Probability)
    P = img_histogram/(M*N);
    
    %% Calculate Cumulative Probability (CP)
    % CP calculation (manual, instead of cumsum) 
    CP_manual = zeros(1, 256);
    CP_manual(1) = P(1);
    for i = 2:256
        CP_manual(i) = CP_manual(i-1) + P(i);
    end
    
    % Ensure the last element of CP is exactly 1
    CP_manual(end) = 1;
    
    %% Multiply CP for the m-bit system
    % Value, dependent on number of bits m 
    n = (2.^m)-1;
    % Multiply
    CPn = n*CP_manual;
    
    %% Floor multiplied CP
    floored = floor(CPn);
    
    %% Equalization
    equalized = zeros(M, N, 'uint8');
    for i = 1:M
        for j = 1:N
            equalized(i, j) = floored(img(i, j) + 1);
        end
    end 
end
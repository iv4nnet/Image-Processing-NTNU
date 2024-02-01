function matched_image = f_matching_hist(random_hist, source_image, m)
    %% Upload equalized and random histogram as a source and target
    [eq_hist_source, ~] = f_equalization(source_image, m);

    %% Calculate equalized histogram from random histogram
    % Get image dimensions
    [M, N] = size(source_image);
    % Calculate Histogram
    img_histogram = random_hist;
    % Calculate Normalized Histogram (Probability)
    P = img_histogram/(M*N);
    % Calculate Cumulative Probability (CP)
    % CP calculation (manual, instead of cumsum) 
    CP_manual = zeros(1, 256);
    CP_manual(1) = P(1);
    for i = 2:256
        CP_manual(i) = CP_manual(i-1) + P(i);
    end
    % Ensure the last element of CP is exactly 1
    CP_manual(end) = 1;
    % Multiply CP for the m-bit system
    % Value, dependent on number of bits m 
    n = (2.^m)-1;
    % Multiply
    CPn = n*CP_manual;
    % Floor multiplied CP
    floored = floor(CPn);
    eq_hist_reference = floored;
    
    %% Create histogram mapping
    % Value, dependent on number of bits m 
    n = (2.^m)-1;
    % Initialize the mapping
    mapping = zeros(1, n+1);
    % Create the mapping based on equalized histograms
    for i = 1:(n+1)
        [~, closest_idx] = min(abs(eq_hist_reference - eq_hist_source(i)));
        mapping(i) = closest_idx - 1;
    end

    %% Apply the histogram matching
    % Initialize the output image
    [M, N] = size(source_image);
    matched_image = zeros(M, N, 'uint8');
    % Apply the matching to each pixel
    for i = 1:M
        for j = 1:N
            matched_image(i, j) = mapping(source_image(i, j) + 1);
        end
    end
end

 %% Function for Image Matching

function matched_image = f_matching(original_image, source_image, m)
    %% Apply histogram equalization function on both images 
    % to find equalized histograms
    [eq_hist_source, ~] = f_equalization(source_image, m);
    [eq_hist_reference, ~] = f_equalization(original_image, m);
    
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

% Week 4. Median Filtering
% This function applies a median filter to an input image given a specific window size.
% It handles the borders by padding the image symmetrically.

function [filtered_img] = f_median_filter(source_image, filt_size)
    % Retrieve the dimensions of the source image
    [img_height, img_width] = size(source_image);
    
    % Define the window size for the median filter
    filter_window = filt_size;
    
    % Initialize the filtered image with zeros
    filtered_img = zeros(img_height, img_width, 'uint8');
    
    % Calculate half the window size for padding purposes
    half_window_size = floor(filter_window / 2);
    
    % Pad the source image symmetrically to accommodate the filter window at the edges
    padded_image = padarray(source_image, [half_window_size, half_window_size], 'symmetric');
    
    % Iterate over each pixel in the source image to apply the median filter
    for row_idx = 1:img_height
        for col_idx = 1:img_width
            % Extract the local region (window) around the current pixel
            local_region = padded_image(row_idx:row_idx+2*half_window_size, ...
                                        col_idx:col_idx+2*half_window_size);
            
            % Calculate the median of the local region and assign it to the corresponding pixel
            filtered_img(row_idx, col_idx) = median(local_region(:));
        end
    end
end

% Week 4. Mean Filtering
% This function applies a mean filter to the input image using a specified window size.
% It pads the image symmetrically to handle edges during the filtering process.

function [filtered_image] = f_mean_filter(img, filter_size)
    % Get the dimensions of the input image
    [img_rows, img_cols] = size(img);
    
    % Initialize the output image to zeros
    filtered_image = zeros(img_rows, img_cols, 'uint8');
    
    % Calculate half of the window size for padding
    half_window = floor(filter_size / 2);
    
    % Pad the image symmetrically to fit the kernel
    padded_image = padarray(img, [half_window, half_window], 'symmetric');
    
    % Perform mean filtering on the input image
    for row = 1:img_rows
        for col = 1:img_cols
            % Define the box around the current pixel based on the window size
            local_window = padded_image(row:row+2*half_window, col:col+2*half_window);
            
            % Calculate the mean of the values within the window and assign to the current pixel
            filtered_image(row, col) = mean(local_window(:));
        end
    end
end
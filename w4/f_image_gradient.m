% Week4. Gradient Calculation
% This function calculates the gradients in the x and y directions of an input image
% using the Sobel operator. It handles image borders by symmetric padding.

function [grad_x, grad_y] = f_image_gradient(input_img)
    % Retrieve the dimensions of the input image
    [img_rows, img_cols] = size(input_img);
    
    % Define the Sobel kernels for x and y directions
    sobel_x = [-1 0 1; -2 0 2; -1 0 1];
    sobel_y = [-1 -2 -1; 0 0 0; 1 2 1];
    
    % Initialize the gradient images with zeros
    grad_x = zeros(img_rows, img_cols, 'uint8');
    grad_y = zeros(img_rows, img_cols, 'uint8');
    
    % Pad the input image symmetrically to handle the borders
    padded_img = padarray(input_img, [1, 1], 'symmetric');
    
    % Calculate the gradient in x and y directions
    for row = 1:img_rows
        for col = 1:img_cols
            % Extract the local 3x3 region around the current pixel
            local_region = double(padded_img(row:row+2, col:col+2));
            
            % Apply the Sobel operator to the local region to find gradients
            grad_x(row, col) = sum(sum(local_region .* sobel_x));
            grad_y(row, col) = sum(sum(local_region .* sobel_y));
        end
    end
    
    % Convert the gradients to an appropriate scale
    % e.g., grad_x = uint8(scale * grad_x);
    %       grad_y = uint8(scale * grad_y);
end

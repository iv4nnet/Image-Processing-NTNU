% Week 4. Sharpening
% This function sharpens an input image using four different Laplacian kernels.
% It outputs four sharpened images, each resulting from convolution with a different kernel.

function [sharpened_img1, sharpened_img2, sharpened_img3, sharpened_img4] = f_image_sharpening(src_img)
    % Define sharpening kernels (Laplacian filters)
    laplacian_kernel1 = [0 1 0; 1 -4 1; 0 1 0]; 
    laplacian_kernel2 = [1 1 1; 1 -8 1; 1 1 1];
    laplacian_kernel3 = [0 -1 0; -1 4 -1; 0 -1 0]; % Alternative laplacian filter
    laplacian_kernel4 = [-1 -1 -1; -1 8 -1; -1 -1 -1];
    
    % Get the dimensions of the input image
    [img_height, img_width] = size(src_img);
    
    % Initialize the output images for each kernel
    sharpened_img1 = zeros(img_height, img_width, 'uint8');
    sharpened_img2 = zeros(img_height, img_width, 'uint8');
    sharpened_img3 = zeros(img_height, img_width, 'uint8');
    sharpened_img4 = zeros(img_height, img_width, 'uint8');
    
    % Pad the source image symmetrically to handle the borders during convolution
    padded_img = padarray(src_img, [1, 1], 'symmetric');
    
    % Perform convolution with each kernel to sharpen the image
    for row = 1:img_height
        for col = 1:img_width
            % Extract the local 3x3 region around the current pixel
            local_region = double(padded_img(row:row+2, col:col+2));
            
            % Apply each kernel to the local region and sum to get the new pixel value
            sharpened_img1(row, col) = sum(sum(local_region .* laplacian_kernel1));
            sharpened_img2(row, col) = sum(sum(local_region .* laplacian_kernel2));
            sharpened_img3(row, col) = sum(sum(local_region .* laplacian_kernel3));
            sharpened_img4(row, col) = sum(sum(local_region .* laplacian_kernel4));
        end
    end
    
    % Scale and offset the results if they are out of the 0-255 range
    % sharpened_img1 = uint8(scale * sharpened_img1 + offset);
end

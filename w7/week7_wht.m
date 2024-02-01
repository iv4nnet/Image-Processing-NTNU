% Week 7. WHT
% This script displays the original image, its WHT transform, and 
% the final result of the inverse WHT transform in one figure. 
% It also plots MSE, RMSE, and PSNR against the compression rate in separate figures.

function week7_wht(~)
    % Load the image
    img = imread('img_grey.jpg');
    img_double = im2double(img); % Convert to double
    
    % Apply Walsh-Hadamard Transform Column Wise
    img_wht_column = fwht(img_double);
    % Apply Walsh-Hadamard Transform Row Wise
    img_wht_rows = fwht(img_wht_column');
    % Get final WHT
    img_wht = img_wht_rows';
    
    % Get image dimensions
    [rows, cols] = size(img_wht);
    % Initialize metrics arrays
    MSE = []; RMSE = []; PSNR = []; compression_rates = [];
    % Gradual Inverse WHT
    for k = 1:min(rows, cols)
        % Create a mask for selected coefficients
        mask = zeros(rows, cols);
        mask(1:k, 1:k) = 1;
    
        % Apply mask and inverse WHT
        img_wht_partial = img_wht .* mask;
        % Inverse WHT - reverse the order of operations
        img_wht_rows_inv = ifwht(img_wht_partial');
        img_wht_column_inv = ifwht(img_wht_rows_inv');
        img_reconstructed = img_wht_column_inv;
    
        % Calculate metrics
        [mse, rmse, psnr] = f_calculate_metrics(img_double, img_reconstructed);
        MSE = [MSE mse]; RMSE = [RMSE rmse]; PSNR = [PSNR psnr];
        compression_rates = [compression_rates, k^2 / (rows * cols)];
    end
    
    % Plotting the original, WHT transform, and final inverse WHT transform
    figure;
    subplot(1,3,1); imshow(img_double); title('Original Image');
    subplot(1,3,2); imshow(log10(abs(img_wht)+1), []); title('WHT Transform');
    subplot(1,3,3); imshow(uint8(img_reconstructed * 255)); title('Inverse WHT Transform');
    % Plotting each metric
    figure; plot(compression_rates, MSE); title('MSE vs Compression Rate');
    figure; plot(compression_rates, RMSE); title('RMSE vs Compression Rate');
    figure; plot(compression_rates, PSNR); title('PSNR vs Compression Rate');
end
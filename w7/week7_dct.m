% Week 7. DCT
% This script displays the original image, its DCT transform, and 
% the final result of the inverse DCT transform in one figure. 
% It also plots MSE, RMSE, and PSNR against the compression rate.

function week7_dct(~)
    % Load the image
    img = imread('img_grey.jpg');
    % Apply DCT Transform
    img_dct = dct2(double(img));
    % Get image dimensions
    [rows, cols] = size(img_dct);
    
    % Initialize metrics arrays
    MSE = []; RMSE = []; PSNR = []; compression_rates = [];
    % Gradual Inverse DCT and plotting
    for k = 1:min(rows, cols)
        % Create a mask for selected coefficients
        mask = zeros(rows, cols);
        mask(1:k, 1:k) = 1;
        % Apply mask and inverse DCT
        img_dct_partial = img_dct .* mask;
        img_reconstructed = idct2(img_dct_partial);
        % Calculate metrics
        [mse, rmse, psnr] = f_calculate_metrics(img, uint8(img_reconstructed));
        MSE(end+1) = mse; RMSE(end+1) = rmse; PSNR(end+1) = psnr;
        compression_rates(end+1) = (k^2) / (rows * cols) * 100; % Compression rate in percentage
    end
    
    % Plotting the original, DCT transform, and final inverse DCT transform
    figure;
    subplot(1,3,1); imshow(img); title('Original Image');
    subplot(1,3,2); imshow(img_dct); title('DCT Transform');
    subplot(1,3,3); imshow(uint8(img_reconstructed)); title('Inverse DCT Transform');
    % Separate figures for each metric
    figure; plot(compression_rates, MSE); title('MSE vs Compression Rate'); xlabel('Compression Rate (%)'); ylabel('MSE');
    figure; plot(compression_rates, RMSE); title('RMSE vs Compression Rate'); xlabel('Compression Rate (%)'); ylabel('RMSE');
    figure; plot(compression_rates, PSNR); title('PSNR vs Compression Rate'); xlabel('Compression Rate (%)'); ylabel('PSNR');
end

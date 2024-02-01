% Week 7. Haar
% This script reads an image, applies the Haar transform up to 4 levels, 
% keeps only the low-frequency components, applies the inverse transform, 
% and calculates MSE, RMSE, and PSNR at each level. 

function week7_haar(~)
    % Load and convert the image to grayscale
    img = imread('img_grey.jpg');
    img_double = im2double(img);
    
    % Initialize metrics arrays
    MSE = []; RMSE = []; PSNR = [];
    % Create a figure for Haar transformed images
    f_haar = figure; 
    % Create a figure for Inverse Haar transformed images
    f_inv_haar = figure;

    for level = 1:4
        % Apply Haar transform up to the specified level
        haar_transformed = f_haar_transform(img_double, level);
    
        % Display Haar transformed image in a subplot
        figure(f_haar);
        subplot(1, 4, level); 
        imshow(log(abs(haar_transformed) + 1), []);
        title(['Haar Level ', num2str(level)]);
    
        % Keep only the low-frequency part
        [rows, cols] = size(haar_transformed);
        mask = zeros(rows, cols);
        mask(1:rows/(2^level), 1:cols/(2^level)) = 1;
        low_freq = haar_transformed .* mask;
    
        % Apply inverse Haar transform
        img_reconstructed = f_inverse_haar_transform(low_freq, level);
    
        % Display inverse Haar transformed image in a subplot
        figure(f_inv_haar);
        subplot(1, 4, level);
        imshow(img_reconstructed, []);
        title(['Inverse Level ', num2str(level)]);

        % Calculate and store metrics
        [mse, rmse, psnr] = f_calculate_metrics(img_double, img_reconstructed);
        MSE = [MSE mse]; RMSE = [RMSE rmse]; PSNR = [PSNR psnr];
    end
    
    % Save metrics plots
    levels = 1:4;
    f = figure; plot(levels, MSE); title('MSE vs Haar Levels');
    %saveas(f, 'week7_haar_MSE.png');
    f = figure; plot(levels, RMSE); title('RMSE vs Haar Levels');
    %saveas(f, 'week7_haar_RMSE.png');
    f = figure; plot(levels, PSNR); title('PSNR vs Haar Levels');
    %saveas(f, 'week7_haar_PSNR.png');
end
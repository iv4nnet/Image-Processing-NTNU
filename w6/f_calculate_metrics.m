%% Function for MSE, RMSE and PSNR calculation 
% for the original and reconstructed images. 

function [mse, rmse, psnr] = f_calculate_metrics(original, reconstructed)
    diff = double(original) - double(reconstructed);
    mse = mean(diff(:).^2);
    rmse = sqrt(mse);
    psnr = 20 * log10(255 / sqrt(mse));
end
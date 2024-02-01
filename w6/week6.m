%  Week 6. Fourier Transform.
%  Reads an image, converts it to grayscale, and calculates its Fourier Transform.
%  Gradually applies inverse Fourier Transform, starting from the central pixel and increasing the area.
%  Calculates MSE, RMSE, and PSNR for each reconstruction.
%  Plots these metrics against the compression rate. 

function week6(~)
    % Read the image
    img = imread('img_grey.jpg');
    % Compute Fourier Transform
    F = fft2(img);
    % Compute Magnitude and Phase
    F_magnitude = abs(F);
    F_phase = angle(F);
    % Display Magnitude and Phase
    figure;
    subplot(1, 2, 1), imshow(log10(F_magnitude), []), title('Magnitude of Fourier Transform in log10');
    subplot(1, 2, 2), imshow(log10(F_phase), []), title('Phase of Fourier Transform in log10');
    
    % Initialize metrics
    MSE = []; RMSE = []; PSNR = []; compression_rates = [];
    % Gradual Inverse Fourier Transform
    [rows, cols] = size(img);
    for k = 1:min(rows, cols)
        F_partial = F;
        F_partial(k+1:end, :) = 0;
        F_partial(:, k+1:end) = 0;
        img_reconstructed = ifft2(F_partial);
        [mse, rmse, psnr] = f_calculate_metrics(img, img_reconstructed);
        MSE = [MSE mse]; RMSE = [RMSE rmse]; PSNR = [PSNR psnr];
        compression_rates = [compression_rates, k^2 / (rows * cols)];
    end

    % Plotting the original and final inverse FT transform
    % figure; imshow(img); title('Original Image');
    % figure; imshow(uint8(img_reconstructed)); title('Inverse DCT Transform');
    % Plot results
    figure; plot(compression_rates, MSE); title('MSE vs Compression Rate'); xlabel('Compression Rate (%)'); ylabel('MSE');
    figure; plot(compression_rates, RMSE); title('RMSE vs Compression Rate'); xlabel('Compression Rate (%)'); ylabel('RMSE');
    figure; plot(compression_rates, PSNR); title('PSNR vs Compression Rate'); xlabel('Compression Rate (%)'); ylabel('PSNR');
end

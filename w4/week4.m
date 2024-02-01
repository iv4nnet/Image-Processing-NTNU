% Week 4. Image Processing
% This function applies noise, filters, and sharpening methods to the input image.
% It then selects the best method based on the minimum difference from the original image.
% Finally, it calculates the gradient magnitude of the original image.

% Load the image
img = imread('img_grey.jpg');

% Add salt and pepper noise with a random density
density = rand(1);
salt_pepper = imnoise(img, 'salt & pepper', density);

% Add speckle noise with a fixed density of 0.2
speckle = imnoise(img, 'speckle', 0.2);

% Create a random-sized averaging filter
windowWidth = round(10 * density);
kernel = ones(windowWidth) / windowWidth ^ 2;
blurredImage = imfilter(img, kernel);

% Apply median and mean filters, and sharpening methods to salt and pepper noise
medianF1 = f_median_filter(salt_pepper, 3);
meanF1 = f_mean_filter(salt_pepper, 3);
[sh11, sh12, sh13, sh14] = f_image_sharpening(salt_pepper);

% Calculate the difference of each method from the original image
diffs = [sum_diff(img, medianF1), sum_diff(img, meanF1), ...
         sum_diff(img, sh11), sum_diff(img, sh12), ...
         sum_diff(img, sh13), sum_diff(img, sh14)];
[~, idx] = min(diffs);
methods = {medianF1, meanF1, sh11, sh12, sh13, sh14};
best1 = methods{idx};

% Apply median and mean filters, and sharpening methods to speckle noise
medianF2 = f_median_filter(speckle, 3);
meanF2 = f_mean_filter(speckle, 3);
[sh21, sh22, sh23, sh24] = f_image_sharpening(speckle);

% Calculate the difference of each method from the original image for speckle noise
diffs_speckle = [sum_diff(img, medianF2), sum_diff(img, meanF2), ...
                 sum_diff(img, sh21), sum_diff(img, sh22), ...
                 sum_diff(img, sh23), sum_diff(img, sh24)];
[~, idx_speckle] = min(diffs_speckle);
methods_speckle = {medianF2, meanF2, sh21, sh22, sh23, sh24};
best2 = methods_speckle{idx_speckle};

% Apply median and mean filters, and sharpening methods to blurred image
medianF3 = f_median_filter(blurredImage, 3);
meanF3 = f_mean_filter(blurredImage, 3);
[sh31, sh32, sh33, sh34] = f_image_sharpening(blurredImage);

% Calculate the difference of each method from the original image for blurred image
diffs_blurred = [sum_diff(img, medianF3), sum_diff(img, meanF3), ...
                 sum_diff(img, sh31), sum_diff(img, sh32), ...
                 sum_diff(img, sh33), sum_diff(img, sh34)];
[~, idx_blurred] = min(diffs_blurred);
methods_blurred = {medianF3, meanF3, sh31, sh32, sh33, sh34};
best3 = methods_blurred{idx_blurred};

% Calculate the gradient of the original image
[Gx, Gy] = f_image_gradient(img);

% Calculate the magnitude of the gradient
magnitude = sqrt(im2double(Gx).^2 + im2double(Gy).^2);

% Visualize the original, distorted, and difference images
figure;

%{
% Display Salt & Pepper Noise image
subplot(3,3,1);
imshow(salt_pepper);
title('Salt & Pepper Noise');
% Display Speckle Noise image
subplot(3,3,2);
imshow(speckle);
title('Speckle Noise');
% Display Blurred image
subplot(3,3,3);
imshow(blurredImage);
title('Blurred Image');

% Assuming best1, best2, and best3 are the best methods chosen for each noise/distortion
% Display Best for Salt & Pepper
subplot(3,3,4);
imshow(best1);
title('Best for Salt & Pepper');
% Display Best for Speckle
subplot(3,3,5);
imshow(best2);
title('Best for Speckle');
% Display Best for Blurred
subplot(3,3,6);
imshow(best3);
title('Best for Blurred');

% Show the difference images
% Difference from Original for Salt & Pepper
subplot(3,3,7);
imshow(imabsdiff(img, best1));
title('Difference from Original - Salt & Pepper');
% Difference from Original for Speckle
subplot(3,3,8);
imshow(imabsdiff(img, best2));
title('Difference from Original - Speckle');
% Difference from Original for Blurred
subplot(3,3,9);
imshow(imabsdiff(img, best3));
title('Difference from Original - Blurred');

% Adjust subplot spacing
set(gcf, 'Position', get(0, 'Screensize'));
%}

% Show gradient images
subplot(1,3,1);
imshow(Gx, []);
title('Gradient in X');

subplot(1,3,2);
imshow(Gy, []);
title('Gradient in Y');

subplot(1,3,3);
imshow(magnitude, []);
title('Gradient Magnitude');
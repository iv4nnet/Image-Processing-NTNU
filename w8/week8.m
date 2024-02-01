% Week 8.
% Applying Image Resizing using Nearest Neighbor Interpolation
% Calculating the SSIM method between your resized image and 
% the image you were using over the previous weeks. 

% Load the images
img1 = imread('photo_cropped_1080x1080.jpg');
original_image = imread('img_grey.jpg');
img1 = rgb2gray(img1);

% Resize image
resized_image = f_resize(img1, 256, 256);

% Calculate SSIM
ssim_value = ssim(resized_image, original_image);

% Display the SSIM value
fprintf('SSIM between the resized image and grayscale image: %.4f\n', ssim_value);

% 
imshow(resized_image)


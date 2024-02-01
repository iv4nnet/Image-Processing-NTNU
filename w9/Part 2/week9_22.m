% Week 9. Part 2.2
% K Means. The script reads a color image, converts it from RGB to 
% Lab color space, and then applies K-means clustering with varying numbers 
% of clusters to quantize the color space. It displays the original and 
% quantized images in a subplot arrangement, showing the effect of 
% different cluster counts on color quantization.

% Read the original image
img = imread('photo_256x256.jpg');

% Convert RGB to Lab
labImg = rgb2lab(img);

% Flatten Lab image
[h, w, ~] = size(labImg);
flatLab = reshape(labImg, h * w, 3);

% Cluster counts
clusters = [2, 4, 8, 16, 32];
rows = 2;
cols = 3;

% Initialize figure
figure;

% Show original
subplot(rows, cols, 1);
imshow(img);
title('Original');

% Iterate over cluster numbers
for i = 1:length(clusters)
    k = clusters(i);

    % K-means
    [idx, ctrs] = kmeans(flatLab, k);

    % Map centers to pixels
    qData = ctrs(idx, :);

    % Reshape to image
    qLab = reshape(qData, h, w, 3);

    % Convert Lab to RGB
    qRGB = lab2rgb(qLab);

    % Subplot position
    r = ceil(i / cols);
    c = mod(i - 1, cols) + 1;

    % Display quantized image
    subplot(rows, cols, (r - 1) * cols + c + 1);
    imshow(qRGB);
    title([num2str(k), ' Clusters']);
end


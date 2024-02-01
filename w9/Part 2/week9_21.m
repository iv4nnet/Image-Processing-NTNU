% Week 9. Part 2.1
% Uniform quantization. The script reads an image and applies uniform 
% quantization to it using different color levels (2, 4, 8, 16, 32). 

% Read an image
img = imread('photo_256x256.jpg');

% Define the levels of quantization
colorLevels = [2, 4, 8, 16, 32]; % 8, 64, 512, 4096, 32768 colors

% Set subplot dimensions
rows = 2; % Rows
cols = 3; % Columns

% Initialize figure for displaying images
figure;

% Show the original image in the first position
subplot(rows, cols, 1);
imshow(img);
title('Original');
axis off;

% Iterate over different quantization levels
for i = 1:length(colorLevels)
    levels = colorLevels(i);

    % Quantize image uniformly
    quantImg = floor(double(img) / (256 / levels)) * (256 / levels);

    % Calculate position for the subplot
    r = ceil(i / cols);
    c = mod(i - 1, cols) + 1;

    % Display each quantized image
    subplot(rows, cols, (r - 1) * cols + c + 1);
    imshow(uint8(quantImg));
    title([num2str(levels) ' Color Levels']);
    axis off;
end

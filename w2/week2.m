% Calculate the image histogram.
% Based on the image histogram see if you can segment your image to at least 3 segments.
% Normalize your image.
% Apply histogram equalization on your image.


%% Read the original image
img = imread('img_grey.jpg');
% Number of bits in image
m = 8;

%% Calculate the image histogram
img_histogram = f_histogram(img);
% Create a figure for the histogram
fig = figure('visible', 'off');
bar(0:255, img_histogram);
xlabel('Intensity Value');
ylabel('Frequency');
title('Image Histogram');
% Save the figure as an image
saveas(fig, 'histogram.png');
% Close the figure
close(fig);

%% Normalize the image
normalized = f_normalization (img);
% Save the result
imwrite(normalized, "normalized.png")
% Calculate the difference
normalized_difference = abs(normalized - img);
imwrite(normalized_difference, "normalized_difference.png");

%% Apply histogram equalization on the image
[~, equalized] = f_equalization (img, m);
% Save the result
imwrite(equalized, "equalized.png")
% Calculate the difference
equalized_difference = abs(equalized - img);
imwrite(equalized_difference, "equalized_difference.png")

%% Apply image segmentation
segmented = f_segmentation(img);
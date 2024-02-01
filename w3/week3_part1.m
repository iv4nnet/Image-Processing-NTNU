% Convert your original image which you cropped your square from, 
% to greyscale and use that image for applying histogram matching to your 256 by 256 image.
% Create a random histogram from using the "rand" function in Matlab 
% as the source histogram to apply histogram matching to your 256 by 256 image.

%% Read 256x256 image
source_image = imread('img_grey.jpg');

%% Calculate and plot the source image histogram
img_histogram1 = f_histogram(source_image);
% Create a figure for the histogram
fig = figure('visible', 'off');
bar(0:255, img_histogram1);
xlabel('Intensity Value');
ylabel('Frequency');
title('Source Image Histogram');
% Save the figure as an image
saveas(fig, 'week3_p1_histogram_source.png');
% Close the figure
close(fig);

%% Read the original image
img1 = imread('original_photo.jpg');
% Convert original image to grey scale
original_image = rgb2gray(img1);
% Number of bits in images
m = 8;

%% Calculate and plot the original image histogram (reference)
img_histogram2 = f_histogram(original_image);
% Create a figure for the histogram
fig = figure('visible', 'off');
bar(0:255, img_histogram2);
xlabel('Intensity Value');
ylabel('Frequency');
title('Reference Image Histogram');
% Save the figure as an image
saveas(fig, 'week3_p1_histogram_original.png');
% Close the figure
close(fig);

%% Apply histogram matching
matched_result = f_matching(original_image, source_image, m);
% Save the result
imwrite(matched_result, "week3_p1_img_matched.png")
% Calculate the difference
matched_difference = abs(matched_result - source_image);
imwrite(matched_difference, "week3_p1_img_matched_difference.png")

%% Calculate and plot the matching image histogram
img_histogram3 = f_histogram(matched_result);

% Create a figure for the histogram
fig = figure('visible', 'off');
bar(0:255, img_histogram3);
xlabel('Intensity Value');
ylabel('Frequency');
title('Matched Image Histogram');
% Save the figure as an image
saveas(fig, 'week3_p1_histogram_matched.png');
% Close the figure
close(fig);





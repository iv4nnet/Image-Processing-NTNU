% Week 3. Part 2.
% Create a random histogram from using the “rand” function in Matlab as 
% the source histogram to apply histogram matching to your 256 by 256 image.

%% Read the 256x256 image
source_image = imread('img_grey.jpg');
% Number of bits in images
m = 8;

%% Calculate and plot the source image histogram
img_histogram = f_histogram(source_image);
% Create a figure for the histogram
fig = figure('visible', 'off');
bar(0:255, img_histogram);
xlabel('Intensity Value');
ylabel('Frequency');
title('Source Image Histogram');
% Save the figure as an image
saveas(fig, 'week3_p2_histogram_original.png');
% Close the figure
close(fig);

%% Generate a random histogram
random_hist = rand(1, 256);
random_hist = random_hist / sum(random_hist) * numel(source_image); % Normalize
random_hist = round(random_hist);

%% Calculate and plot the random histogram
% Create a figure for the histogram
fig = figure('visible', 'off');
bar(0:255, random_hist);
xlabel('Intensity Value');
ylabel('Frequency');
title('Random Histogram');
% Save the figure as an image
saveas(fig, 'week3_p2_histogram_random_week3.png');
% Close the figure
close(fig);

%% Apply histogram matching using the random histogram
matched_result = f_matching_hist(random_hist, source_image, m);

% Save the result
imwrite(matched_result, "week3_p2_image_matched.png")
% Calculate the difference
matched_difference = abs(matched_result - source_image);
imwrite(matched_difference, "week3_p2_image_matched_difference.png")

%% Calculate and plot the matching image histogram
img_histogram_matched = f_histogram(matched_result);
% Create a figure for the histogram
fig = figure('visible', 'off');
bar(0:255, img_histogram_matched);
xlabel('Intensity Value');
ylabel('Frequency');
title('Matched Image Histogram');
% Save the figure as an image
saveas(fig, 'week3_p2_histogram_matched.png');
% Close the figure
close(fig);

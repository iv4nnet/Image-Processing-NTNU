%% Function for image histogram calculation

function [img_histogram] = f_histogram (img)
    %% Histogram calculation
    % Check the size of the image
    [M, N] = size(img);
    % Initialize the histogram array with 256 bins for grayscale intensities
    img_histogram = zeros(1, 256);
    % For each element in image add +1 to the corresponding value in the histogram
    for i = 1:M
        for j = 1:N
            img_histogram(img(i,j) + 1) = img_histogram(img(i,j) + 1) + 1;
        end
    end
end
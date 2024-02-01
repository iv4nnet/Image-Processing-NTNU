%% Function for Image Normalization

function [normalized] = f_normalization (img)
    % Find the maximum and minimum pixel values in the image
    max_value = max(img, [], 'all');
    min_value = min(img, [], 'all');
    
    % Initialize the normalized parameter for the loop
    normalized = img;
    
    % Normalize image
    for i = 1:max_value
        normalized(i) = round((255 * (img(i) - min_value) ) / ( max_value - min_value));
    end
end

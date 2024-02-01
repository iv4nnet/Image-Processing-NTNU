%% Function for Inverse Haar Transform Calculation
% Performs the inverse Haar transform on an image. 
% It works by applying the single-level inverse Haar transform 
% to both rows and columns of the image in reverse order. 

function img = f_inverse_haar_transform(transformed, level)
    [rows, cols] = size(transformed);
    img = transformed;
    
    for l = level:-1:1
        % Inverse Haar transform for columns
        for j = 1:cols
            img(1:rows, j) = f_single_level_inverse_haar(img(1:rows, j)');
        end

        % Inverse Haar transform for rows
        for i = 1:rows
            img(i, 1:cols) = f_single_level_inverse_haar(img(i, 1:cols));
        end
    end
end
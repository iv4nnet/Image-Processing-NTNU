%% Function for Haar Transform Calculation

function transformed = f_haar_transform(img, level)
    [rows, cols] = size(img);
    transformed = img;
    
    for l = 1:level
        % Haar transform for rows
        for i = 1:rows
            transformed(i, 1:cols) = f_single_level_haar(transformed(i, 1:cols));
        end
        % Haar transform for columns
        for j = 1:cols
            transformed(1:rows, j) = f_single_level_haar(transformed(1:rows, j)');
        end
    end
end
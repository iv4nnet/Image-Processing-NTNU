%% Function for Single Line Haar Transform Calculation
% Performs the basic operation of the Haar transform 
% for a single line (either a row or a column of the image)

function line_transformed = f_single_level_haar(line)
    % Determine the length of the input line
    n = length(line);

    % Initialize the transformed line array with zeros
    line_transformed = zeros(1, n);

    % Calculate half the length of the line
    half_n = n / 2;
    
    % Loop through the first half of the line
    for i = 1:half_n
        % Calculate the average of each pair of elements
        % This represents the low-frequency component
        line_transformed(i) = (line(2 * i - 1) + line(2 * i)) / 2;

        % Calculate the difference between the same pair of elements
        % This represents the high-frequency component
        line_transformed(half_n + i) = (line(2 * i - 1) - line(2 * i)) / 2;
    end
end

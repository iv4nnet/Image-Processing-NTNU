%% Function for Single Line Inverse Haar Transform Calculation
% Performs the basic operation of the inverse Haar transform for a single line 
% (either a row or a column of an image).

function line_transformed = f_single_level_inverse_haar(line)
    % Determine the length of the input line
    n = length(line);

    % Initialize the transformed line array with zeros
    line_transformed = zeros(1, n);

    % Calculate half the length of the line
    half_n = n / 2;
    
    % Loop through the first half of the line
    for i = 1:half_n
        % Reconstruct the original values from the low and high frequency components
        % The first original value is the average plus the difference
        line_transformed(2 * i - 1) = (line(i) + line(half_n + i)) / 2;

        % The second original value is the average minus the difference
        line_transformed(2 * i) = (line(i) - line(half_n + i)) / 2;
    end
end

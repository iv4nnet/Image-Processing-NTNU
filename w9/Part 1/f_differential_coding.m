% Week 9. 
% For each zero in the array, it counts how many consecutive zeros occur. 

function output = f_differential_coding(input)
    zerosCount = 0;
    rowCount = 1;
    output = [];
    for index = 1:length(input)
        if input(index) == 0
            zerosCount = zerosCount + 1;
            if zerosCount == 15
                newRow = [zerosCount, 0, 0];
                output = [output; newRow];
                rowCount = rowCount + 1;
                zerosCount = 0; % Reset zero count for next element
            end
        else
            % Determine the number of bits for the non-zero value
            bitSize = floor(log2(abs(input(index)))) + 1;
            
            % Create a new row with count of zeros, bit size, and the value
            newRow = [zerosCount, bitSize, input(index)];

            % Add the new row to the output
            if rowCount == 1
                output = newRow;
            else
                output = [output; newRow]; % Append as a new row
            end
            rowCount = rowCount + 1;
            zerosCount = 0; % Reset zero count for next element
        end
        
        % If output is empty, skip to the next iteration
        if isempty(output)
            continue
        end
    end
end

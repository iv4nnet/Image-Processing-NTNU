% Week 9. ZigZag function

function result = f_zigzag(mat)
    rows = size(mat, 1); % Rows in matrix
    cols = size(mat, 2); % Columns in matrix
    d = 2; % Starting diagonal
    result = [];
    % Loop over diagonals
    while d <= rows + cols
        diagElems = []; % Elements in current diagonal
        % Iterate over matrix elements
        for i = 1:rows
            for j = 1:cols
                % Add to diagonal if indices sum to current diagonal
                if i + j == d
                    diagElems = [diagElems, mat(i,j)];
                end
            end
        end
        % Append in reverse for even diagonals
        if mod(d, 2) == 0
            result = [result, fliplr(diagElems)];
        else
            result = [result, diagElems];
        end
        d = d + 1;
    end
end

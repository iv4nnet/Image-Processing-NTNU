%% Function To Generate Walsh Matrix

function W = f_generate_walsh_matrix(N)
    % Base case
    if N == 1
        W = 1;
        return;
    end
    
    % Recursive step
    W_prev = f_generate_walsh_matrix(N / 2);
    W = [W_prev, W_prev; W_prev, -W_prev];
end
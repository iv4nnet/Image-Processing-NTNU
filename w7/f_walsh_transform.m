%% Function for Walsh Transform

function W = f_walsh_transform(A)
    % Generate Walsh matrix
    WalshMatrix = f_generate_walsh_matrix(size(A, 1));
    
    % Apply Walsh transform
    W = WalshMatrix * double(A) * WalshMatrix';
end
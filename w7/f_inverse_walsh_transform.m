%% Function for Inverse Walsh Transform

function A_inv = f_inverse_walsh_transform(W)
    % Generate Walsh matrix
    WalshMatrix = f_generate_walsh_matrix(size(W, 1));
    
    % Apply inverse Walsh transform
    A_inv = WalshMatrix' * W * WalshMatrix;
    A_inv = uint8(A_inv);
end
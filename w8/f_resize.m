% Week 8.
% Optimized Image Resizing using Nearest Neighbor Interpolation.


function resized_img = f_resize(img, target_height, target_width)

    % Determine the size of the original image
    [orig_height, orig_width, num_channels] = size(img);

    % Initialize the resized image
    resized_img = zeros(target_height, target_width, num_channels, 'like', img);

    % Calculate the scaling factors
    scale_x = orig_width / target_width;
    scale_y = orig_height / target_height;

    % Generate grid for target image coordinates
    [X, Y] = meshgrid(1:target_width, 1:target_height);

    % Find the nearest neighbor coordinates in the source image
    src_X = round((X - 0.5) * scale_x + 0.5);
    src_Y = round((Y - 0.5) * scale_y + 0.5);

    % Boundary handling: replicate the nearest edge pixel for out-of-bound indices
    src_X = min(max(src_X, 1), orig_width);
    src_Y = min(max(src_Y, 1), orig_height);

    % Perform resizing for each channel using vectorized indexing
    for channel = 1:num_channels
        channel_data = img(:, :, channel);
        resized_img(:, :, channel) = channel_data(sub2ind([orig_height, orig_width], src_Y, src_X));
    end
end


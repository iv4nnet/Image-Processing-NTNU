%% Helper function to calculate the sum of absolute differences

function [sum_diff] = sum_diff(original, processed)
    sum_diff = sum(sum(abs(original - processed)));
end
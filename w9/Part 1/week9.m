% Week 9. JPEG Compression.
% This script performs the JPEG compression. 
% It includes the subtraction of 128 from pixel values, DCT transformation, 
% quantization, and placeholders for the zigzag scan and differential coding.

% Load the image
img = imread('img_grey.jpg');

% Subtract 128 from each pixel value to shift the range
img = double(img) - 128;

% Set block size
blkSize = 8;

% Initialize 3D matrix for storing blocks
imgBlocks = zeros(blkSize, blkSize, numel(img)/(blkSize^2));

% Extract and store 8x8 blocks
cnt = 1;
for x = 1:blkSize:size(img, 1)
    for y = 1:blkSize:size(img, 2)
        blk = img(x:x+blkSize-1, y:y+blkSize-1);
        imgBlocks(:,:,cnt) = blk;
        cnt = cnt + 1;
    end
end

% Compute DCT for each block
numBlks = numel(img)/(blkSize^2);
dctBlks = zeros(blkSize, blkSize, numBlks);
for b = 1:numBlks
    dctBlks(:,:,b) = dct2(imgBlocks(:,:,b));
end

% Define the quantization matrix and quantize DCT blocks
QMat = [16 11 10 16 24 40 51 61; 
 12 12 14 19 26 58 60 55; 
 14 13 16 24 40 57 69 56; 
 14 17 22 29 51 87 80 62; 
 18 22 37 56 68 109 103 77; 
 24 35 55 64 81 104 113 92; 
 49 64 78 87 103 121 120 101; 
 72 92 95 98 112 100 103 99];
quantDct = zeros(blkSize, blkSize, numBlks);
for b = 1:numBlks
    quantDct(:,:,b) = round(dctBlks(:,:,b)./QMat);
end

% Zigzag scan on quantized DCT blocks
zigzagDct = zeros(blkSize*blkSize, numBlks);
for b = 1:numBlks
    zigzagDct(:,b) = f_zigzag(quantDct(:,:,b));
end

% Encode AC components
ACComp = [];
for j = 1:numBlks
    if j == 1
        ACComp = [1 0 0];
        temp = f_differential_coding(zigzagDct(:,j));
        ACComp = [ACComp; temp];
    else
        ACComp = [ACComp; [j 0 0]];
        temp = f_differential_coding(zigzagDct(:,j));
        ACComp = [ACComp; temp];
    end

end

% Compute DC components
DCCoeffs = reshape(quantDct(1,1,:), 32, 32)';

% Calculate DPCM for DC components
DPCM = zeros(size(DCCoeffs));
DPCM(:,1) = DCCoeffs(:,1);
for j = 2:32
    DPCM(:,j) = DCCoeffs(:,j) - DCCoeffs(:,j-1);
end

% Display results for a specific block in subfigures
blkNum = 880;
% Initialize figure
figure;
% Original Block
subplot(2, 2, 1);
imshow((imgBlocks(:,:,blkNum) + 128), []);
title('Original Block');
% Decoded Block
subplot(2, 2, 2);
imshow(imgBlocks(:,:,blkNum), []);
title('After substracting 128');
% DCT Block
subplot(2, 2, 3);
imshow(dctBlks(:,:,blkNum), []);
title('DCT Block');
% Quantized DCT Block
subplot(2, 2, 4);
imshow(quantDct(:,:,blkNum), []);
title('Quantized DCT Block');

% Extract AC components for the block
idx1 = find(ACComp(:,1) == blkNum & ACComp(:,3) == 0, 1);
idx2 = find(ACComp(:,1) == blkNum+1 & ACComp(:,3) == 0, 1);
ACBlock = ACComp(idx1+1:idx2-1,:);


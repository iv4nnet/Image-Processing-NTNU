# Image-Processing-NTNU
Coursework Project for Image Processing course at NTNU.

## Week 1
Capture an image with your cell phone.
Using a photo editing tool:
- Crop a square larger than 1024 by 1024 pixels out of your image.
- Resize the image to 256 by 256 pixels.
- Convert the image to greyscale.

Photo editing software:
For cropping and resizing, I used Fotor.
For converting to greyscale Matlab "img_to_grey" function was used.

Upload the 256 by 256 greyscale image here but keep all the different versions of the image since we will be using it later on in the semester.

## Week 2
First, I created a function "f\_histogram" to calculate the image histogram. For each element in the image, I added +1 to the corresponding value in the histogram. 
The "f\_segmentation" function divides the image into three parts. All pixels with intensities less than 78 are set to 0 (black); all pixels with intensities between 78 and 125 to 128 (a mid-tone gray); all pixels with intensities greater than or equal to 125 to 255 (white).

To create the normalization function f\_normalization for the image I implemented the formula:
\[ g_N(I) = round(\frac{I - min_A}{max_A - min_A} * 255) \]

For histogram equalization, I created the "f\_equalization" function which returns two matrices: "floored", which is the floored cumulative probability, and "equalized", which is the equalized image.

## Week 3
I converted my original image to greyscale, and then calculated the histogram with the "f\_histogram" function. Then I repeated the same process with my 256x256 image. After histogram calculation for both source and target images, I applied the "f\_matching" function, where the original image was used as a reference, and 256x256 as a source. 

In the second part of week three, I created a histogram using Matlab's "rand" function as the source histogram to apply histogram matching to my 256 by 256 image. As the original image, I used my 256x256 image, and its histogram was calculated with the "f\_histogram" function. For the target, I calculated a histogram with the "rand(1, 256)" function. To apply histogram marching between the original image and the random histogram, I modified the function to "f\_matching\_hist". Here the function takes three parameters: random\_hist, original\_image, and m. 

## Week 4
For local enhancement, I applied distortions and found the best way to remove each of them. 

## Week 6
For the Fourier Transform, I used fft2 and gradually applied ifft2 function. I also calculated the MSE, RMSE, and PSNR for each reconstruction of the image and drew plots. 

## Week 7
For this week, I continued my work on different image transformations. I created a plot calculating MSE, RMSE, and PSNR for each inverse transformation in the case of DCT, Walsh, and Hadamard transform using the transform functions Matlab already has.

When it came to the Haar transform, I wrote my own transform and inverse transform functions. I calculated the Haar transform up to level 4 for my images. At each level, I kept the section of the image that has all low frequencies and applied the inverse transform. I plotted the MSE, RMSE, and PSNR values at each level.

## Week 8
As mentioned in the class this week, I performed image resizing. I came up with a creative way to resize the cropped image (1024 by 1024) to the 256 by 256 pixels. I calculated the SSIM method between my resized image and the image I was using over the previous weeks. I also tried to improve my resize method with small changes.

## Week 9_1
This week, I focused on JPEG compression. I used my 256 by 256 image and went through the steps in JPEG compression. That is:

- Dividing the image into different 8*8 blocks
- Subtracting 128 from the values
- Calculating the DCT transform for the images
- Calculating the quantization using the common matrix

I provided a compression block for the DC values and compression blocks for the AC coefficients in the different image blocks. When it came to calculating the compression, I just simply used the [(r,s),c] representation for each block.

## Week 9-2
I applied different color quantization techniques for my image. This could be using K-means clustering, K-nearest neighbor, or any other clustering technique I saw fit.

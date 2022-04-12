clear all;
X = imread('image59.jpg');
R = X(:,:,1);
image(R), colormap([[0:1/255:1]', zeros(256,1), zeros(256,1)]), colorbar;
imshow(R);
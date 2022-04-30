function [newimg] = makeMoreYellow(img)
    %%%figure, hold on, imshow(img);
    %img = imread('image55.jpg');
    %subplot(2, 2, 1);
    %imshow(img);
    %title('Original Image', 'FontSize', 20);
    %impixelinfo;
    %drawnow;
    red = img(:, :, 1);
    green = img(:, :, 2);
    blue = img(:, :, 3);
    %create a mask same size as image that indicates 'yellow' pixels
    isyellow = red > 25; %78
    %isyellow = red > 18;
    % Extract the largest blob only
    %isyellow = bwareafilt(isyellow, 1);
    %set red and blue channel to 0 when image is yellow. set green channel to max
    %no idea if that's what asked by the assignment
    %subplot(2, 2, 2);
    %imshow(isyellow);
    %title('Yellow Mask', 'FontSize', 20);
    %drawnow;
    red(isyellow) = 238;
    green(isyellow) = 220;
    blue(isyellow) = 0;
    %recombine all channels
    newimg = cat(3, red, green, blue);
    %subplot(2, 2, 3);
    %imshow(newimg);
    %%%figure, hold on, imshow(newimg);
    %title('Changed Image', 'FontSize', 20);
    %drawnow;
    %imwrite(newimg,"newImage.jpg");
end
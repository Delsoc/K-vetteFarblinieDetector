function [RGB] = sharpBW(bw)
    a = bw;
    %a = imread('neueGelbFilter.jpg');
    %w = fspecial('laplacian',0);
    %w2 = [0 -1 0; -1 4 -1; 0 -1 0];
    w3 = [-1 -1 -1; -1 8 -1; -1 -1 -1];
    %d = imfilter(a,w2,'replicate');
    RGB = imfilter(a, w3, 'replicate');
    %figure,imshow(d);
    %figure,imshow(d2);
end



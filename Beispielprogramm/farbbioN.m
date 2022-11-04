% Zerlegung eines Bildes in HSV
% [H,S,V]=farbbioN(I)

function [H,S,V]=farbbioN(I)

figure, imshow(I);
I=rgb2hsv(I);

figure, imagesc(I(:,:,1));title('Farbton'); colormap(gray);
figure, imagesc(I(:,:,2));title('Sättigung'); colormap(gray);
figure, imagesc(I(:,:,3));title('Intensität'); colormap(gray);

H=double(I(:,:,1));
S=double(I(:,:,2));
V=double(I(:,:,3));
maS=max(max(S));
S=S*255/maS;
S=uint8(S);
maV=max(max(V));
V=V*255/maV;
V=uint8(V);

imwrite(H, 'Bild_H.jpg');
imwrite(S, 'Bild_S.jpg');
imwrite(V, 'Bild_V.jpg');
figure, hold on, imshow(H);
figure, hold on, imshow(S);
figure, hold on, imshow(V);


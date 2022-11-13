% Zerlegung eines Bildes in HSV
% [H,S,V]=farbbioN(I)
% Author: Antje Ohlhoff

function [H,S,V]=farbbioN(I)

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


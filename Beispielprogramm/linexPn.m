% Linescan horizontal eines Bildes
%
% [x]=linexPn(I,a)  I=Eingangsbildmatrix 
%                 a=Höhe der Linie in Prozent der Bildhöhe von oben
%
%                 x=Grauwertvektor=Linescan
%
function [x]=linexPn(I,a)


[hoehe,breite]=size(I);
anz=hoehe*breite;
br=floor(breite);

%hoehe in Pixel
i=floor(hoehe*a/100);


for j=1:breite
    x(j)=I(i,j);
    jj(j)=j;
end

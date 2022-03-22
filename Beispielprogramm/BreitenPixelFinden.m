% Findet einen Linescan der möglichst nicht durch eine Sencrechte linie
% geht
% Breitenpx=BreitenPixelFinden(I) I=Eingangsbildmatrix
%                                 Breitenpx=Pixel wo eine Optimale Linie
%                                 gefunden wurde
%              
%

function breitenpx=BreitenPixelFinden(I)

Pix = 1000;

% liefert die Groesse des Bildes
% Verwandelt es in double zur rechnung
[hoehe,breite]=size(I);
I = double(I);


for i=1:hoehe
    for j=1:breite
        if I(i,j) <= 130
            I(i,j) = 0;
        end
    end
end

zwanzigzeiler = zeros([2,20]);

for j=Pix:Pix+19
    temp = 0;
    for i=1:hoehe
        temp = temp + I(i,j);
    end
    zwanzigzeiler(1,j+1-Pix) = temp;
    zwanzigzeiler(2,j+1-Pix) = j;

end
sorted_L = sortrows(zwanzigzeiler',1)';
breitenpx = sorted_L(2,1);
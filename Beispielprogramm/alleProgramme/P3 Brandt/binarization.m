% Binariziert ein Bild nach einen Schwellwert
%   BI=binarization(E_Bild,Schwelle)
%   BI = Binariziertes Ausgangsbild
%   E_Bild = Eingansbild
%   Schwelle = Alle werte die größer als der schwellwert sind werden zu 255

function BI=binarization(E_Bild,Schwelle)

[hoehe,breite] = size(E_Bild);
E_Bild = double(E_Bild); 

for i=1:hoehe
    for j=1:breite
       if E_Bild(i,j) > Schwelle
           E_Bild(i,j) = 255;
       else
           E_Bild(i,j) = 0;
       end
    end
end

BI = uint8(E_Bild);
% Nickel
% Finden der ersten Kante im Bild
%
% [x,y]=ersteKanteFinden(A,h)
%              A=Eingangsbildmatrix
%              h=Linescanhöhe
%              x=X-Wert für gefundene Kante
%              y=Y-Wert für gefundene Kante
function [x,y]=ersteKanteFindenP3(B,h)
[hoehe,breite]=size(B);    
    x=0;
    y=0;
    x=linexPn(B,h);
    f=5.3; % Welchen Wert muss der Extrempunkt haben, um als Kante gewertet zu werden
    for i=1:floor(length(x)/3) %die erste Kante wird nur im ersten drittel des Bildes gesucht
     if abs(x(i))>f
        x=i;
        y=floor(hoehe*h/100);
%        disp("Kante gefunden");
        break
     end
    end
end
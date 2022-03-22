%
% PX=MMproPXfinden(sobelline,gausline) PX=gemittelte Anzahl der Pixel in
%                                         einem Millimeter
%                                      sobelline=Ein Linescan durch ein
%                                                Sobelgefiltertes Bild für
%                                                die nullstellen
%                                      sobelline=Ein Linescan durch das
%                                                original Bild für
%                                                die Die hohe der Peaks
%

function [PX,Kanten]=MMproPXfinden(sobelline,gausline)
 
[i,laenge] = size(sobelline);
Kanten = zeros([i,laenge]);
KantenIndex = [];
sobelline = double(sobelline);
schwellwert = max(gausline)*0.55; %berechnet einen Schwellwert der Bildabhängig ist aus dem Hösten Peak

%Berechnet die Kanten indem es gückt wenn ein Vorzeichen wechsel vorhanden
%ist und der peak über einen Schwellwert ist 
e = 0;
for i=2:laenge %i=2 wegen i-1
    if sobelline(i) <= 0 && sobelline(i-1) > 0 
        %dann nullpunkt
        if gausline(i) > schwellwert
            %dann kante
            Kanten(i)= 255;
            e = e + 1;
            KantenIndex(e) = i;
        end
    end
end


%abstand kanten ausrechnen
%Nimmt den durchschnitlichen abstand zwischen 2 kanten
sum = 0;
Z = 0;
for i=3:e-3 % i=3 und -3 u, die ersten und lezten kanten auszulassen hilft bei den Y werten
    sum = sum + (KantenIndex(i+1) - KantenIndex(i));
    Z = Z +1;
end
PX = sum/Z;
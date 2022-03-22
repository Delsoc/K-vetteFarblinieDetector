% Findet einen Linescan der möglichst nicht durch eine Wagerechte linie
% geht
% hohenpx=HoehenPixelFinden(I) I=Eingangsbildmatrix
%                              hohenpx=Pixel wo eine Optimale Linie
%                              gefunden wurde
%              
%

function hohenpx=HoehenPixelFinden(I)

Pix = 708; %Start-Such-pixel


% liefert die Groesse des Bildes
% Verwandelt es in double zur rechnung
[hoehe,breite]=size(I);
I = double(I);

%bearbeitet das Eingangsbild nochmal und macht die zwischenräume zwischen
%den kästchen schwarz um nacher eine bessere Linie zu finden
for i=1:hoehe
    for j=1:breite
        if I(i,j) <= 130
            I(i,j) = 0;
        end
    end
end

 %Speichert die Summe aller werte im linescan und deren Pixelindex
ScanLineSumme_undPixelIndex = zeros([2,20]);

for i=Pix:Pix+19 %Geht durch 20 untereinander liegende Linien
    temp = 0;
    for j=1:breite
        temp = temp + I(i,j);
    end
    %berechnet die summe und index 
    ScanLineSumme_undPixelIndex(1,i+1-Pix) = temp;
    ScanLineSumme_undPixelIndex(2,i+1-Pix) = i;

end
%Sucht die Minimale summe um Wagerechte Linien zu vermeinden
sorted_L = sortrows(ScanLineSumme_undPixelIndex',1)'; 
hohenpx = sorted_L(2,1);
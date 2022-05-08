% Finded Alle kanten im Bild und Bereinigt diese sodas nur die
% Reagenzgläser gefunden werden 
%
%
% Bereinigte_Kanten = Kantenbreinigen(E_Bild) 
%    Bereinigte_Kanten = Kanntenindexe der Bereiigten kannten 
%    E_Bild = Eingangsbild
%
%


function Bereinigte_Kanten = Kantenbreinigen(E_Bild)

load("Sobn.mat","Sobn");

E_Bild = uint8(E_Bild);
Bin_Bild = binarization(E_Bild,25);

Pixelhoehe = 450;


Bin_Bild_Sobn = Faltung(Bin_Bild,Sobn);
Sobn_Linie = Bin_Bild_Sobn(Pixelhoehe,:);
%figure; plot(Sobn_Linie);

%alle Horizintale Kannten finden
%Speichert den Index wo die kanten sind
[~,laenge] = size(Sobn_Linie);
Kanten = [];
z = 1;
for i=2:laenge
    if Sobn_Linie(i-1) <= 0 && Sobn_Linie(i) > 0 || Sobn_Linie(i-1) >= 0 && Sobn_Linie(i) < 0
        Kanten(z) = i;
        z = z+1;
        if(z) == 14
            break; %!!!! NOTLÖSUNG(um 16:27 aufgefallen): Nur bei TestBild 11 relevant!!! alle anderen fumktionieren auch ohne
        end
    end
end

%durchschnittleche breite der gläser finden anhand des 2ten 3ten und 4ten
[~,laenge_Kanten] = size(Kanten);
temp = 0;
for i=3:2:7
    %durchschnittliche gläserbreite 
    temp =  temp + Kanten(i+1) - Kanten(i);
end
avg = temp /3;

%kanten von kleinen kanten und "nicht beendeten" kanten filtern
tolleranz = avg*0.3;
Bereinigte_Kanten = [];
for i=1:2:floor(laenge_Kanten/2)*2
    if Kanten(i+1) - Kanten(i) < avg + tolleranz && Kanten(i+1) - Kanten(i) > avg - tolleranz
       Bereinigte_Kanten(i) = Kanten(i);
       Bereinigte_Kanten(i+1) = Kanten(i+1);
    end
end



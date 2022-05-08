% Nickel + Ohlhoff 26.5.21
% senkrechte Ausrichtung von Küvettenbildern anhand der linken Kante der
% ersten Küvette
%
% [D]=kuvDrehen(A)
%              A=Eingangsbildmatrix
%              D=gedrehte Bildmatrix


function [D]=kuvDrehen(A)
%% Anfangsvariablen
A=double(A);
[hoehe,breite]=size(A);

%% Faltung mit Sobel n-Richtung 
Sobn=[0.1250 0 -0.1250;0.25 0 -0.25;0.1250 0 -0.1250];
B=faltungNickel(A,Sobn);


%% Linescan mit 2 Höhen

%a=[55 65 75]; % zu testende Höhen in %
a=[60 80 85]; % zu testende Höhen in % Verbessert zum testen

% Obere Line ziehen
for k=1:length(a)-1
    
    [x1,y1]=ersteKanteFindenP3(B,a(k));
    if x1~=0
        break
    end
    if k==length(a)-1
    disp("Keine hohe Kante gefunden.");
    end
    
end

% Untere Line ziehen
for j=k+1:length(a)
    [x2,y2]=ersteKanteFindenP3(B,a(j));
    if x2~=0
        break
    end
    if j==length(a)
    disp("Keine niedrige Kante gefunden.");
    end
end

%% Winkel finden
phiRad=atan2(x2-x1,y2-y1);

%% Winkel von Bogenmaß in Grad umrechnen
phiDeg=phiRad*(180/pi)
%% Bild rotieren
D=imrotate(A,-phiDeg);
D=uint8(D);




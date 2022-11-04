%Findet die Obere(Wasser)-/ Mittlere(Farb)-/ Untere(Glasskrümmungs)-/
%/-Kannte in Px
%
% [ErsteLiniePX,MittlereLiniePX,UntereLiniePX]=OMU_KantenFinden(GradAusgBild)
%   ErsteLiniePX = Der Pixel von dem Eingansbild in dem die Wasslinie
%                  gefunden wurde
%   MittlereLiniePX = Der Pixel von dem Eingansbild in dem die Farblinie
%                     gefunden wurde
%   UntereLiniePX = Der Pixel von dem Eingansbild in dem die Glass
%                   gefunden wurde
%   GradAusgBild = Das gedrehte und zugeschnittene Bild
%


function [ErsteLiniePX,MittlereLiniePX,UntereLiniePX]=OMU_KantenFinden(GradAusgBild)

load("Sobm.mat","Sobm");

[hoehe,breite] = size(GradAusgBild);
GwertLinie = GradAusgBild(:,round(breite/2));
%figure(); plot(GwertLinie);
%I = Faltung(GradAusgBild,Sobm);
%SLinie = I(:,round(breite/2));
%figure(); plot(SLinie);


%Erste Linie Suchen

%Bineraziert das Bild um bei der Suche der Wasserkannte zu helfen
Bin_Bild = binarization(GradAusgBild,mean(GwertLinie(1:ceil(hoehe/5)))*1.8);
Bin_Bild = double(Bin_Bild);  

ErsteLiniePX = 1;
Bin_Linie = Bin_Bild(:,round(breite/2));
%figure; plot(Bin_Linie); 
%Geht von unteren ersten vierten bis zum anfang des bildes und sucht die
%erste Kannte
for e=ceil(hoehe/4):-1:1
    if Bin_Linie(e) < 255 && Bin_Linie(e-1) == 255% && GwertLinie(e) >avg
        ErsteLiniePX = e;
        break;
    end
end

    
% Mittlere kannte finden
%sucht die Mittlere Linie vom ende des 1/5s bis zum 4/5 über eine Grauwertschwelle
%(Grauwertschwelle weil massive probleme eine gute kannte zu finden im
%ersten Bild)
MittlereLiniePX = 1;
for e=ceil(hoehe/5):ceil(hoehe/5*4)
    if GwertLinie(e) >= mean(GwertLinie)*1.18
        MittlereLiniePX = e;
        break;
    end
end
    

    
%Untere kante Finden
%sucht die kleine weiße linie die immer unten im bild ist
%setzt alle werte in der scanLinie die nicht im letzten viertel sind auf 0
%um andere kannten zu unterdrücken
GwertLinieUnten = [];
for e=1:hoehe
    if e < ceil((hoehe/4)*3)
        GwertLinieUnten(e) = 0;
    else 
        GwertLinieUnten(e) = GwertLinie(e);
    end    
end
%sucht dann den größten Grauwert
[~,UntereLiniePX] = max(GwertLinieUnten);

%Visuell darstellen
GradAusgBild(MittlereLiniePX,:) = 255;
GradAusgBild(ErsteLiniePX,:) = 255;
GradAusgBild(UntereLiniePX,:) = 255;
%figure("Name","VerbessertSW"); imagesc(Bin_Bild); colormap(gray);
figure("Name","WinkelVerbessert mit Linien"); imagesc(GradAusgBild); colormap(gray);
    
%figure("Name","VerbessertSW"); imagesc(OO); colormap(gray);
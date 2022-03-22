% Schneided die Einzelden Behelter aus
%
%   EinzelnesGlass=GlassAusschneiden(E_Bild,i,Bereinigte_Kanten)
%   EinzelnesGlass = Bildmatrix von einem einzigen Glases
%   E_Bild = Eingangbild
%   i = index der auktuellen kannte
%   Bereinigte_Kanten = Die Bereinigten kannten wo die Gläser gefunden
%   wurde



function EinzelnesGlass=GlassAusschneiden(E_Bild,i,Bereinigte_Kanten)
    load("Sobm.mat","Sobm");
    
    %Links und rechts abschneiden mit extra weil Glas noch nicht grade ist
    EinzelnesGlass = E_Bild(:,Bereinigte_Kanten(i)-20:Bereinigte_Kanten(i+1)+20);
    [hoehe_zwischen,breite_Zwischen] = size(EinzelnesGlass);
    
    
    SobmZwischen = Faltung(EinzelnesGlass,Sobm);
    OberreKante = 0;
    GwertLinie = EinzelnesGlass(:,round(breite_Zwischen/2));
    %figure(); plot(GwertLinie);
    KantenLinie = SobmZwischen(:,round(breite_Zwischen/2));
    %figure(); plot(KantenLinie);
    %Geht in der mitte von oben durch und finded die erste kannte
    for e=2:hoehe_zwischen
        if KantenLinie(e-1) <=0 && KantenLinie(e) > 0 || KantenLinie(e-1) >=0 && KantenLinie(e) < 0 || abs(e) > 1
            if GwertLinie(e) >50
                OberreKante = e;
                break;
            end
        end
    end
       
    
    [~,UntereKanteIndex] = min(GwertLinie(400:600));    
    UntereKanteIndex = UntereKanteIndex + 400;
    %den minimalen wert bestimmen um so eine erste schätzung zu bestimmen
    
    %um dieses minimum herrum nach der min vertikalen linie suchen(schneided den messstab gut ab)
    ScanLineSumme_undPixelIndex = [2,20];
    for e = UntereKanteIndex-10:UntereKanteIndex+10
        ScanLinie = E_Bild(e,Bereinigte_Kanten(i)-20:Bereinigte_Kanten(i+1)+20);
        s = sum(ScanLinie);
        ScanLineSumme_undPixelIndex(1,e-(UntereKanteIndex-11)) = s;
        ScanLineSumme_undPixelIndex(2,e-(UntereKanteIndex-11)) = e;
    end
    sorted_L = sortrows(ScanLineSumme_undPixelIndex',1)'; 
    UntereKanteIndex = sorted_L(2,1); %index der MininalenLinie
    
    %Glass oben und unden rechts links ausschneiden mit den neuen werten
    EinzelnesGlass = E_Bild(OberreKante-40:UntereKanteIndex,Bereinigte_Kanten(i)-20:Bereinigte_Kanten(i+1)+20);

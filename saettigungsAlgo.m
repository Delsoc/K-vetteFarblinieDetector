function [detectedHeight] = saettigungsAlgo(RGB, showStepsOfKuevette)
% Diese Funktion erwartet als Eingabe das ausgeschnittene Bild der Küvette.
% Es wird das Verfahren "Extraktion des Sättigungsbildes" angewendet, um die Höhe 
% der gewünschten Linie zu detektieren

    % Farbton H, Sättigung S und Dunkelstufe V des Eingabebildes auslesen
    % und zwischenspeichern
    [H,S,V]=farbbioN(RGB);
    
    %figure,imshow(H), hold on;
    %figure,imshow(S), hold on;
    %figure,imshow(V), hold on;

    %grayImg = im2gray(S);

    % Sättigungsbild in ein Schwart-Weiß-Bild konvertieren
    bw = im2bw(S, 0.9);
    
    %%%figure, imshow(grayImg);hold on;

    % Höhe und Breite des Bildes ermitteln und speichern
    [hoehe,breite] = size(bw);

    % Grauwertlinie vertikal durch die Mitte der Küvette erstellen
    GwertLinie = bw(:,round(breite/2));
    
    %%%figure, plot(GwertLinie,'r','LineWidth',0.5), hold on;
    
    % Die Grauwertlinie um die ersten 80 Pixel verkürzen
    for i=80 : length(GwertLinie)
        copyGwertLinie(i-79,1) = GwertLinie(i,1);
    end

    try
        % verkürzste Grauwertlinie durchgehen und ersten Wert suchen, der
        % gleich 0 ist. Diesen Wert als detektierte Höhe festlegen
        indexes = find(copyGwertLinie == 0);
        detectedHeight = indexes(1:1)+80;

        % Höhe korrigieren
        detectedHeight = hoehe - detectedHeight;
    catch
        % Falls kein Wert 0 ist, dann wird die Höhe auf 0 gesetzt
        detectedHeight = 0;
    end
end
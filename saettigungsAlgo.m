function [detectedHeight] = saettigungsAlgo(RGB, showStepsOfKuevette)
% Diese Funktion erwartet als Eingabe das ausgeschnittene Bild der Küvette.
% Es wird das Verfahren "Extraktion des Sättigungsbildes" angewendet, um die Höhe 
% der gewünschten Linie zu detektieren

    % Eingabebild speichern unter original RGB 
    originalRGB = RGB;

    % ggf. Zwischenschritt zeigen
    if showStepsOfKuevette
        figure, hold on;
        title('Sättigung: 1. Eingabebild');
        imshow(RGB);
    end

    % Farbton H, Sättigung S und Dunkelstufe V des Eingabebildes auslesen
    % und zwischenspeichern
    [H,S,V]=farbbioN(RGB);
    
    % ggf. Zwischenschritt zeigen
    if showStepsOfKuevette
        figure, hold on;
        title('Sättigung: 2. Sättigungsbild extrahieren');
        imshow(RGB);
    end

    % Sättigungsbild in ein Schwart-Weiß-Bild konvertieren
    bw = im2bw(S, 0.9);
    
    % ggf. Zwischenschritt zeigen
    if showStepsOfKuevette
        figure, hold on;
        title('Sättigung: 3. Schwarz-Weiß-Bild erstellen');
        imshow(RGB);
    end

    % Höhe und Breite des Bildes ermitteln und speichern
    [hoehe,breite] = size(bw);

    % Grauwertlinie vertikal durch die Mitte der Küvette erstellen
    GwertLinie = bw(:,round(breite/2));
    
    % ggf. Zwischenschritt zeigen
    if showStepsOfKuevette
        figure, hold on;
        plot(GwertLinie,'r','LineWidth',0.5)
        title('Sättigung: 4. Grauwertlinie erstellen');
    end
    
    % Die Grauwertlinie um die ersten 80 Pixel verkürzen
    for i=80 : length(GwertLinie)
        copyGwertLinie(i-79,1) = GwertLinie(i,1);
    end

    % ggf. Zwischenschritt zeigen
    if showStepsOfKuevette
        figure, hold on;
        plot(GwertLinie,'r','LineWidth',0.5)
        title('Sättigung: 5. Grauwertlinie anpassen');
    end

    try
        % verkürzste Grauwertlinie durchgehen und ersten Wert suchen, der
        % gleich 0 ist. Diesen Wert als detektierte Höhe festlegen
        indexes = find(copyGwertLinie == 0);
        detectedHeight = indexes(1:1)+80;

        % ggf. Zwischenschritt zeigen
        if showStepsOfKuevette
            figure, imshow(RGB), hold on;
            [~, breite] = size(RGB);
            line([0 breite],[detectedHeight detectedHeight],'Color','r','LineWidth',2);
            title('Sättigung: 6. ermittelte Linie');
        end

        % Höhe korrigieren
        detectedHeight = hoehe - detectedHeight;
    catch
        % Falls kein Wert 0 ist, dann wird die Höhe auf 0 gesetzt
        detectedHeight = 0;
    end

    

end
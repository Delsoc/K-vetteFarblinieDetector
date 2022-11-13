 function [calculatedHeight] = redplaneLineAlgo(RGB, showStepsOfKuevette)
% Diese Funktion erwartet als Eingabe das ausgeschnittene Bild der Küvette.
% Es wird das Verfahren "Extraktion des Rotkanals" angewendet, um die Höhe 
% der gewünschten Linie zu detektieren
    
    % Eingabebild speichern unter original RGB 
    originalRGB = RGB;
    
    % ggf. Zwischenschritt zeigen
    if showStepsOfKuevette
        figure, hold on;
        title('Rotkanal: 1. Eingabebild');
        imshow(RGB);
    end

    % Das Eingabe Bild in ein Grauwertbild konvertieren, indem der Rotkanal
    % extrahiert wird
    R = RGB(:,:,1);

    % ggf. Zwischenschritt zeigen
    if showStepsOfKuevette
        figure, hold on;
        title('Rotkanal: 2. Rotkanal extrahieren');
        imshow(R);
    end

    % Höhe und Breite des Bildes ermitteln und zwischenspeichern
    [hoehe,breite] = size(R);

    % Grauwertlinie vertikal durch die Mitte der Küvette erstellen
    GwertLinie = R(:,round(breite/2));

    % ggf. Zwischenschritt zeigen
    if showStepsOfKuevette
        figure, hold on;
        plot(GwertLinie,'r','LineWidth',0.5)
        title('Rotkanal: 3. Grauwertlinie erstellen');
    end


    try
        % Position des ersten Wertes suchen (Küvette von oben nach unten),
        % wo der Rotwert unter 25 liegt und als detektierte Höhe festlegen
        indexes = find(GwertLinie < 25);
        calculatedHeight = indexes(1:1);

        % Höhe korrigieren
        calculatedHeight = hoehe - calculatedHeight;
    catch
        % Falls kein Rotwert unter 25 gefunden werden konnte, wird die Höhe
        % auf 0 gesetzt
        calculatedHeight = 0;
    end

    % ggf. Zwischenschritt zeigen
    if showStepsOfKuevette
        figure, imshow(originalRGB), hold on;
        [~, breite] = size(originalRGB);
        line([0 breite],[(calculatedHeight+25) (calculatedHeight+25)],'Color','r','LineWidth',2);
        title('Rotkanal: 4. ermittelte Linie');
    end

end







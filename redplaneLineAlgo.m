 function [calculatedHeight] = redplaneLineAlgo(RGB)
% Diese Funktion erwartet als Eingabe das ausgeschnittene Bild der Küvette.
% Es wird das Verfahren "Extraktion des Rotkanals" angewendet, um die Höhe 
% der gewünschten Linie zu detektieren

    % Das Eingabe Bild in ein Grauwertbild konvertieren, indem der Rotkanal
    % extrahiert wird
    R = RGB(:,:,1);

    % Höhe und Breite des Bildes ermitteln und zwischenspeichern
    [hoehe,breite] = size(R);

    % Grauwertlinie vertikal durch die Mitte der Küvette erstellen
    GwertLinie = R(:,round(breite/2));


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
end







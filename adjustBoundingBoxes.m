function [stats] = adjustBoundingBoxes(stats, croppedUndistortedImages, imgNr)
% Diese Funktion erwartet als Eingabe die stats/Rahmenbegrenzungen der
% detektierten Küvetten, die ausgeschnittenen Bilder der Küvetten, sowie
% den Index der aktuellen Bilditeration
% Diese Funktion passt die Rahmenbegrenzungen an. Die Küvette wird in der
% Breite um 70% reduziert und zentralisiert. Die angepasste Höhe ist
% abhängig von der Bilditeration. Die ermittelten Küvetten des ersten
% Bildes werden um 40% in der Höhe reduziert, wobei der obere Teil
% reduziert wird. Bei jeder weiteren Bilditerationen werden die jeweiligen
% Küvetten um weitere 2% in der Höhe reduziert.

    % Feldnamen von stats in fn speichern
    fn = fieldnames(stats);
    
    % definieren, um wie viel weitere Prozent an Höhe bei jeder weiteren
    % Bilditeration die jeweiligen Küvetten an Höhe reduziert werden
    % sollen
    stepPerImageIndex = 0.02;

    % Über jede Küvette des aktuellen Bildes iterieren
    for k=1:length(stats)
    
        % das Bild der aktuellen Küvette zwischenspeichern
        curCroppedImg = croppedUndistortedImages{k};

        % Bild in ein Graubild konvertieren
        gray = im2gray(curCroppedImg);

        % Bild in ein Schwarz-Weiß-Bild konvertieren
        bw = im2bw(curCroppedImg, 0.3);

        % Höhe und Breite des Schwarz-Weiß-Bildes der Küvette auslesen
        [hoehe,breite] = size(bw);

        % Grauwertlinie vertikal durch die Mitte der Küvette erstellen und
        % zwischenspeichern
        GwertLinie = bw(:,round(breite/2));

        % Den tatsächlichen Werte der Küvette finden und in indexes 
        % speichern. Dann erste Position und letzte Position als
        % Küvettendecke und Küvettenboden festlegen
        indexes = find(GwertLinie == 1);
        [lastIndex,~] = size(indexes);
        KuevetteDecke = indexes(1,1);
        KuevetteBoden = indexes(lastIndex,1);

        % Die Positionen der Rahmenbegrenzung für die aktuelle Küvette
        % auslesen und in fiels speichern
        % field(1)= linkester pixelstand (x1)
        % field(2)= oberster pixelstand (y1)
        % field(3)= breite
        % field(4)= höhe
        field = stats(k).(fn{1});

        % Breite der Küvette auf 30% reduzieren und in der Breite
        % zentralisieren
        field(1) = field(1) + (0.3 * field(3));
        field(3) = field(3) * 0.3;

        % Die Höhe um 40% + Bilditeration*2% von reduzieren und
        % in der Höhe ausrichten ausrichten, sodass von oben ausgeschnitten
        % wird
        field(4) = (KuevetteBoden -2) * (0.6 - stepPerImageIndex*(imgNr-1));
        field(2) = field(2) + (KuevetteBoden -2) * (1- (0.6 - stepPerImageIndex*(imgNr-1)));

        % Die überarbeiteten Rahmenbegrenzungen überschreiben bzw speichern
        stats(k).(fn{1}) = field;
    end
end
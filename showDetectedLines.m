function showDetectedLines(image, stats, imgIndex)
% Diese Funktion erwartet als Eingabe das aktuelle Bild mit den Küvetten,
% die jeweiligen Rahmenbegrenzungen bzw stats und den aktuellen Bildindex
% Die Funktion erstellt ein figure, indem das Eingabebild 3 Mal zu sehen
% ist. Je Algorithmus ein Bild. In den Bildern sind die jeweiligen
% detektierten Linien der Algorithmen farbig eingezeichnet.


    % die Matrizen mit den detektierten Höhen der jeweiligen Algorithmen
    % laden
    detectedLineHeightMatrixHough = matfile('detectedLineHeightMatrixHough.mat').detectedLineHeightMatrixHough;
    detectedLineHeightMatrixRedPlane = matfile('detectedLineHeightMatrixRedPlane.mat').detectedLineHeightMatrixRedPlane;
    detectedLineHeightMatrixSaettigung = matfile('detectedLineHeightMatrixSaettigung.mat').detectedLineHeightMatrixSaettigung;

    % Figure erstellen
    figure('Name',strcat("Image ",num2str(imgIndex)),'NumberTitle','off');
    
    % Bild mit den detektierten Linien des Hough Algorithmus anzeigen
    % position im figure festlegen
    subplot(3,1,1),
    
    % Bild anzeigen
    imshow(image), hold on;
    
    % titel festlegen
    title('HoughAlgo');

    % über die Küvetten iterieren
    for k = 1 : length(stats)
        % Rahmenbegrenzung der aktuellen Küvette laden
        BB = stats(k).BoundingBox;

        % untere Küvettenhöhe bestimmen
        bottomHeightKuevette = BB(4)+BB(2);

        % detektierte Linie des Algorithmus für diese Küvette laden
        currentHeightInPixel = detectedLineHeightMatrixHough(imgIndex,k);

        % Höhe korrigieren
        lineHeight = bottomHeightKuevette - currentHeightInPixel;

        % Linie an der Position der Küvette in dem Bild zeichnen
        line([BB(1) BB(1)+BB(3)],[lineHeight lineHeight],'Color','r','LineWidth',1);
    end

    % Bild mit den detektierten Linien des Verfahrens 
    % "Extraktion des Rotkanals" anzeigen
    % position im figure festlegen
    subplot(3,1,2),

    % Bild anzeigen
    imshow(image), hold on;

    % titel festlegen
    title('RedPlaneAlgo');

    % über die Küvetten iterieren
    for k = 1 : length(stats)
        % Rahmenbegrenzung der aktuellen Küvette laden
        BB = stats(k).BoundingBox;

        % untere Küvettenhöhe bestimmen
        bottomHeightKuevette = BB(4)+BB(2);

        % detektierte Linie des Algorithmus für diese Küvette laden
        currentHeightInPixel = detectedLineHeightMatrixRedPlane(imgIndex,k);

        % Höhe korrigieren
        lineHeight = bottomHeightKuevette - currentHeightInPixel;

        % Linie an der Position der Küvette in dem Bild zeichnen
        line([BB(1) BB(1)+BB(3)],[lineHeight lineHeight],'Color','r','LineWidth',1);
    end

    % Bild mit den detektierten Linien des Verfahrens 
    % "Extraktion des Sättigungsbildes" anzeigen
    % position im figure festlegen
    subplot(3,1,3),

    % Bild anzeigen
    imshow(image), hold on;

    % titel festlegen
    title('SaettigungAlgo');

    % über die Küvetten iterieren
    for k = 1 : length(stats)
        % Rahmenbegrenzung der aktuellen Küvette laden
        BB = stats(k).BoundingBox;

        % untere Küvettenhöhe bestimmen
        bottomHeightKuevette = BB(4)+BB(2);

        % detektierte Linie des Algorithmus für diese Küvette laden
        currentHeightInPixel = detectedLineHeightMatrixSaettigung(imgIndex,k);

        % Höhe korrigieren
        lineHeight = bottomHeightKuevette - currentHeightInPixel;

        % Linie an der Position der Küvette in dem Bild zeichnen
        line([BB(1) BB(1)+BB(3)],[lineHeight lineHeight],'Color','r','LineWidth',1);
    end
end
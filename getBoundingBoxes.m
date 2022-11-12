function [stats,centroids] = cutKuevetten(RGB)
% Rahmenbegrenzungen der einzelnen Küvetten des Bildes
% ermitteln und zwischenspeichern    

    % Schwellenwert festlegen
    threshold = 0.07;

    % Bild wird anhand des Schwellenwerts in ein Schwarz-Weiß-Bild
    % konvertiert
    I = rgb2gray(RGB);
    bw = imbinarize(I, threshold );

    % Alle Objekte von dem Schwarz-Weiß-Bild entfernen, die weniger als 300
    % Pixel groß sind.
    bw = bwareaopen(bw,300);
    
    % Lücken in dem Schwarz-Weiß-Bild schließen
    se = strel('disk',9);
    bw = imclose(bw, se);
    
    % Rahmenbegrenzungen ermitteln. 
    % B hat die Pixelwerte der Grenzen aller Objekte
    % L hat die Pixelwerte der Grenzen, einschliesslich dessen, was sich 
    % darin befindet
    [B,L] = bwboundaries(bw);
    
    % Über alle gefundenen Objekte/Küvetten iterieren
    for k=1:length(B)
        % Die Rahmenbegrenzungen der aktuellen Küvette in der Sammlung
        % boundary speichern
        boundary = B{k};
    end

    % Beschriftungsmatrix des Schwarz-Weiß-Bild erstellen 
    % (Achter-Verbundenheit)
    [bwLabel,num] = bwlabel(bw,8);
    
    % Die Rahmenbegrenzungen durch regionprops ermitteln und in stats
    % speichern
    stats = regionprops(bwLabel, 'BoundingBox');
    
    % Die Schwerpunkt der gefundenen Objekte durch regionprops ermitteln 
    % und in stats speichern
    centroids = regionprops(bw,'centroid');
end
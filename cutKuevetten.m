function [croppedImages] = cutKuevetten(RGB, stats)
% Die Funktion cutKuevetten erwartet als Eingabe ein Bild, sowie die mit
% regionprops ermittelten stats/Rahmenbegrenzungen der einzelnen gefundenen
% Objekte in dem Bild. Diese Objekte werden dann aus dem Bild geschnitten
% und in der Sammluing "croppedImages" gespeichert.

    % es wird über jedes gefundene Objekt iteriert
    for k = 1 : length(stats)

        % Die Rahmenbegrenzungen des aktuellen Objekts werden ausgelesen
        % und zwischengespeichert
        BB = stats(k).BoundingBox;
        
        % Das Objekt wird aus dem Bild geschnitten und croppedImages
        % angehangen
        croppedImages{k} = imcrop(RGB, [BB(1) BB(2) BB(3) BB(4)]);
    end
end
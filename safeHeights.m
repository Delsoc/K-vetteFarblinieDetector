function safeHeights(heightPixelHoughAlgo,heightPixelRedPlaneAlgo,heightPixelSaettigungsAlgo, imageIndex, kuevetteIndex, completeHeight)
    % Diese Funktion bekommt als Eingabe die detektierten Höhen der Linie
    % der aktuellen Küvette. Außerdem wird der Bildindex, der Küvettenindex,
    % sowie die Gesamthöhe der Küvette als Eingabe erwartet. Diese Funktion
    % speichert die ermittelten Höhen und die komplette Höhe der Küvette in
    % jeweils eine Matrix

    % Die Matrizen, in denen die Werte gespeichert werden, werden geladen
    completeKuevettenHeight = matfile('completeKuevettenHeight.mat').completeKuevettenHeight;
    detectedLineHeightMatrixHough = matfile('detectedLineHeightMatrixHough.mat').detectedLineHeightMatrixHough;
    detectedLineHeightMatrixRedPlane = matfile('detectedLineHeightMatrixRedPlane.mat').detectedLineHeightMatrixRedPlane;
    detectedLineHeightMatrixSaettigung = matfile('detectedLineHeightMatrixSaettigung.mat').detectedLineHeightMatrixSaettigung;

    % Die Werte werden in den jeweiligen Matrizen gespeichert
    completeKuevettenHeight(imageIndex,kuevetteIndex) = completeHeight;
    detectedLineHeightMatrixHough(imageIndex,kuevetteIndex) = heightPixelHoughAlgo;
    detectedLineHeightMatrixRedPlane(imageIndex,kuevetteIndex) = heightPixelRedPlaneAlgo;
    detectedLineHeightMatrixSaettigung(imageIndex,kuevetteIndex) = heightPixelSaettigungsAlgo;
    
    % Die Matrizen werden gespeichert.
    save('completeKuevettenHeight.mat','completeKuevettenHeight');
    save('detectedLineHeightMatrixHough.mat','detectedLineHeightMatrixHough');
    save('detectedLineHeightMatrixRedPlane.mat','detectedLineHeightMatrixRedPlane');
    save('detectedLineHeightMatrixSaettigung.mat','detectedLineHeightMatrixSaettigung');
end

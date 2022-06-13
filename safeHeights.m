function safeHeights(kuevetteHeight, heightPixelHoughAlgo,heightPixelRedPlaneAlgo,heightPixelSaettigungsAlgo, imageIndex, kuevetteIndex, durationBetweenImagesInMinutes)
    %The position of all components required for photography are fixed at
    %all times! the length of 1 pixel was evaluated: 93px = 7mm = 7000µm.
    %1px = 0,075mm = 75000µm

    detectedLineHeightMatrixHough = matfile('detectedLineHeightMatrixHough.mat').detectedLineHeightMatrixHough;
    detectedLineHeightMatrixRedPlane = matfile('detectedLineHeightMatrixRedPlane.mat').detectedLineHeightMatrixRedPlane;
    detectedLineHeightMatrixSaettigung = matfile('detectedLineHeightMatrixSaettigung.mat').detectedLineHeightMatrixSaettigung;

    detectedLineHeightMatrixHough(imageIndex,kuevetteIndex) = kuevetteHeight-heightPixelHoughAlgo;
    detectedLineHeightMatrixRedPlane(imageIndex,kuevetteIndex) = kuevetteHeight-heightPixelRedPlaneAlgo;
    detectedLineHeightMatrixSaettigung(imageIndex,kuevetteIndex) = kuevetteHeight-heightPixelSaettigungsAlgo;
    

    save('detectedLineHeightMatrixHough.mat','detectedLineHeightMatrixHough');
    save('detectedLineHeightMatrixRedPlane.mat','detectedLineHeightMatrixRedPlane');
    save('detectedLineHeightMatrixSaettigung.mat','detectedLineHeightMatrixSaettigung');
end

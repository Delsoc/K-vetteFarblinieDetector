function safeHeights(heightPixelHoughAlgo,heightPixelRedPlaneAlgo,heightPixelSaettigungsAlgo, imageIndex, kuevetteIndex, completeHeight)
    %The position of all components required for photography are fixed at
    %all times! the length of 1 pixel was evaluated: 93px = 7mm = 7000µm.
    %1px = 0,075mm = 75000µm

    completeKuevettenHeight = matfile('completeKuevettenHeight.mat').completeKuevettenHeight;
    detectedLineHeightMatrixHough = matfile('detectedLineHeightMatrixHough.mat').detectedLineHeightMatrixHough;
    detectedLineHeightMatrixRedPlane = matfile('detectedLineHeightMatrixRedPlane.mat').detectedLineHeightMatrixRedPlane;
    detectedLineHeightMatrixSaettigung = matfile('detectedLineHeightMatrixSaettigung.mat').detectedLineHeightMatrixSaettigung;

    completeKuevettenHeight(imageIndex,kuevetteIndex) = completeHeight;
    detectedLineHeightMatrixHough(imageIndex,kuevetteIndex) = heightPixelHoughAlgo;
    detectedLineHeightMatrixRedPlane(imageIndex,kuevetteIndex) = heightPixelRedPlaneAlgo;
    detectedLineHeightMatrixSaettigung(imageIndex,kuevetteIndex) = heightPixelSaettigungsAlgo;
    
    save('completeKuevettenHeight.mat','completeKuevettenHeight');
    save('detectedLineHeightMatrixHough.mat','detectedLineHeightMatrixHough');
    save('detectedLineHeightMatrixRedPlane.mat','detectedLineHeightMatrixRedPlane');
    save('detectedLineHeightMatrixSaettigung.mat','detectedLineHeightMatrixSaettigung');
end

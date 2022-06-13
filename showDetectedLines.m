function showDetectedLines(image, stats, centroids, imgIndex)
    detectedLineHeightMatrixHough = matfile('detectedLineHeightMatrixHough.mat').detectedLineHeightMatrixHough;
    detectedLineHeightMatrixRedPlane = matfile('detectedLineHeightMatrixRedPlane.mat').detectedLineHeightMatrixRedPlane;
    detectedLineHeightMatrixSaettigung = matfile('detectedLineHeightMatrixSaettigung.mat').detectedLineHeightMatrixSaettigung;

    figure('Name',strcat("Image ",num2str(imgIndex)),'NumberTitle','off');
    subplot(3,1,1), %houghAlgo
    imshow(image), hold on;
    title('HoughAlgo');

    for k = 1 : length(stats)
        BB = stats(k).BoundingBox;
        bottomHeightKuevette = BB(4)+BB(2);
        currentHeightInPixel = detectedLineHeightMatrixHough(imgIndex,k);
        lineHeight = bottomHeightKuevette - currentHeightInPixel;
        line([BB(1) BB(1)+BB(3)],[lineHeight lineHeight],'Color','r','LineWidth',1);
        debug = 0 ;
    end


    subplot(3,1,2), %RedPlaneAlgo
    imshow(image), hold on;
    title('RedPlaneAlgo');

    for k = 1 : length(stats)
        BB = stats(k).BoundingBox;
        bottomHeightKuevette = BB(4)+BB(2);
        currentHeightInPixel = detectedLineHeightMatrixRedPlane(imgIndex,k);
        lineHeight = bottomHeightKuevette - currentHeightInPixel;
        line([BB(1) BB(1)+BB(3)],[lineHeight lineHeight],'Color','b','LineWidth',1);
        debug = 0 ;
    end


    subplot(3,1,3), %SaettigungAlgo
    imshow(image), hold on;
    title('SaettigungAlgo');

    for k = 1 : length(stats)
        BB = stats(k).BoundingBox;
        bottomHeightKuevette = BB(4)+BB(2);
        currentHeightInPixel = detectedLineHeightMatrixSaettigung(imgIndex,k);
        lineHeight = bottomHeightKuevette - currentHeightInPixel;
        line([BB(1) BB(1)+BB(3)],[lineHeight lineHeight],'Color','g','LineWidth',1);
        debug = 0 ;
    end
    debugPoint = 0;
end
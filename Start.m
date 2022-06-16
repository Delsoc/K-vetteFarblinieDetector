init();

%93px=3mm / 1px = 32,258 μm
for img=1 : length(images)
    
    originalImage = images{img};
    %image = imread("newImage.jpg");
    %%%figure,imshow(originalImage), hold on;
    %%%figure
    undistortedImage = undistortImage(originalImage, cameraParams);
    moreYellowImage = makeMoreYellow(undistortedImage); %TODO: should be done in init() or an extra prepare method
    %figure,hold on, imshow(image);
    
    %figure,hold on, imshow(image);
    [stats,centroids] = getBoundingBoxes(moreYellowImage); %TODO (noch sicherer): wenn 10 nicht erkannt werden sollten, dann solange weiter versuchen (mit anderen Bildern), bis 10 Objekte gefunden wurden
    firstStats = stats;
    stats = adjustBoundingBoxes(stats);
    
    croppedMoreYellowImages = cutKuevetten(moreYellowImage,stats);
    croppedUndistortedImages = cutKuevetten(undistortedImage, stats);
    
    for croppedImg=1 : length(croppedMoreYellowImages)
        %figure, hold on, imshow(croppedImages{img});
        [rows, columns, numberOfColorChannels] = size(croppedMoreYellowImages{croppedImg});
    
        %houghAlgo
        calculatedHeightHough = houghAlgo3(croppedUndistortedImages{croppedImg}(:,:,1));
        %%%line([0 columns],[calculatedHeightHough calculatedHeightHough],'Color','r','LineWidth',2);
        %%%figure, imshow(croppedUndistortedImages{croppedImg}), hold on;
        %%%line([0 columns],[calculatedHeightHough calculatedHeightHough],'Color','r','LineWidth',2);
        %redPlaneAlgo
        calculatedHeightRedPlane = redplaneLineAlgo(croppedMoreYellowImages{croppedImg});
        %%%figure, imshow(croppedMoreYellowImages{croppedImg}), hold on;
        %%%line([0 columns],[calculatedHeightRedPlane calculatedHeightRedPlane],'Color','b','LineWidth',2);
        %%%figure, imshow(croppedUndistortedImages{croppedImg}), hold on;
        %%%line([0 columns],[calculatedHeightRedPlane calculatedHeightRedPlane],'Color','b','LineWidth',2);
        %saettigungsAlgo
        calculatedHeightSaettigungsAlgo = saettigungsAlgo(croppedUndistortedImages{croppedImg});
        %%%figure, imshow(croppedUndistortedImages{croppedImg}), hold on;
        %%%line([0 columns],[calculatedHeightSaettigungsAlgo calculatedHeightSaettigungsAlgo],'Color','g','LineWidth',2);
        %%%figure, imshow(croppedMoreYellowImages{croppedImg}), hold on;
        %%%line([0 columns],[calculatedHeightSaettigungsAlgo calculatedHeightSaettigungsAlgo],'Color','g','LineWidth',2);
        %% 
        safeHeights(rows,calculatedHeightHough,calculatedHeightRedPlane,calculatedHeightSaettigungsAlgo,img,croppedImg,5);
        %%%debugPoint = 0;
    end
    showDetectedLines(undistortedImage, firstStats, centroids, img);
    %%%close all;%cpu auslastung sonst zu hoch wenn alle figures angezeigt werden
end



calcAndSafeInExcel(length(images));
debugPoint = 0;



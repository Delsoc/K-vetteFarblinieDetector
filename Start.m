init();

for img=1 : length(images)
    
    originalImage = images{img};
    undistortedImage = undistortImage(originalImage, cameraParams);
    [stats,centroids] = getBoundingBoxes(undistortedImage);
    
    firstStats = stats; %TODO: Berechnungen anpassen!

    croppedUndistortedImages = cutKuevetten(undistortedImage, stats);
    stats = adjustBoundingBoxes(stats, croppedUndistortedImages, img);
    recroppedUndistortedImages = cutKuevetten(undistortedImage, stats);
    %GwertliniePlotten(croppedUndistortedImages);
    %close all;
    for croppedImg=1 : length(recroppedUndistortedImages)
        [completeHeight, completeWidth] = size(croppedUndistortedImages{croppedImg});
        %figure, hold on, imshow(croppedUndistortedImages{croppedImg});
        [rows, columns, numberOfColorChannels] = size(recroppedUndistortedImages{croppedImg});
    
        %houghAlgo
        calculatedHeightHough = houghAlgo3(recroppedUndistortedImages{croppedImg});
        %%%line([0 columns],[calculatedHeightHough calculatedHeightHough],'Color','r','LineWidth',2);
        %%%figure, imshow(croppedUndistortedImages{croppedImg}), hold on;
        %%%line([0 columns],[calculatedHeightHough calculatedHeightHough],'Color','r','LineWidth',2);
        %redPlaneAlgo
        calculatedHeightRedPlane = redplaneLineAlgo(recroppedUndistortedImages{croppedImg});
        %%%figure, imshow(croppedMoreYellowImages{croppedImg}), hold on;
        %%%line([0 columns],[calculatedHeightRedPlane calculatedHeightRedPlane],'Color','b','LineWidth',2);
        %%%figure, imshow(croppedUndistortedImages{croppedImg}), hold on;
        %%%line([0 columns],[calculatedHeightRedPlane calculatedHeightRedPlane],'Color','b','LineWidth',2);
        %saettigungsAlgo
        calculatedHeightSaettigungsAlgo = saettigungsAlgo(recroppedUndistortedImages{croppedImg});
        %%%figure, imshow(croppedUndistortedImages{croppedImg}), hold on;
        %%%line([0 columns],[calculatedHeightSaettigungsAlgo calculatedHeightSaettigungsAlgo],'Color','g','LineWidth',2);
        %%%figure, imshow(croppedMoreYellowImages{croppedImg}), hold on;
        %%%line([0 columns],[calculatedHeightSaettigungsAlgo calculatedHeightSaettigungsAlgo],'Color','g','LineWidth',2);
        safeHeights(calculatedHeightHough,calculatedHeightRedPlane,calculatedHeightSaettigungsAlgo,img,croppedImg, completeHeight);

    end
    showDetectedLines(undistortedImage, firstStats, centroids, img);
end

calcAndSafeInExcel(length(images),str2num(expInfos{2}));
debugPoint = 0;



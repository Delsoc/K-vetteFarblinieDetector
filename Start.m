init();

%93px=3mm / 1px = 32,258 μm

originalImage = images{1};
%image = imread("newImage.jpg");
figure,imshow(originalImage), hold on;
figure
undistortedImage = undistortImage(originalImage, cameraParams);
moreYellowImage = makeMoreYellow(undistortedImage); %TODO: should be done in init() or an extra prepare method
%figure,hold on, imshow(image);

%figure,hold on, imshow(image);
stats = getBoundingBoxes(moreYellowImage); %TODO (noch sicherer): wenn 10 nicht erkannt werden sollten, dann solange weiter versuchen (mit anderen Bildern), bis 10 Objekte gefunden wurden
stats = adjustBoundingBoxes(stats);

croppedMoreYellowImages = cutKuevetten(moreYellowImage,stats);
croppedUndistortedImages = cutKuevetten(undistortedImage, stats);


for img=1 : length(croppedMoreYellowImages)
    %figure, hold on, imshow(croppedImages{img});
    [rows, columns, numberOfColorChannels] = size(croppedMoreYellowImages{img});

    %houghAlgo
    calculatedHeight = houghAlgo(croppedMoreYellowImages{img});
    line([0 columns],[calculatedHeight calculatedHeight],'Color','r','LineWidth',2);
    figure, imshow(croppedUndistortedImages{img}), hold on;
    line([0 columns],[calculatedHeight calculatedHeight],'Color','r','LineWidth',2);
    %redPlaneAlgo
    calculatedHeightRedPlane = redplaneLineAlgo(croppedMoreYellowImages{img});
    figure, imshow(croppedMoreYellowImages{img}), hold on;
    line([0 columns],[calculatedHeightRedPlane calculatedHeightRedPlane],'Color','b','LineWidth',2);
    figure, imshow(croppedUndistortedImages{img}), hold on;
    line([0 columns],[calculatedHeightRedPlane calculatedHeightRedPlane],'Color','b','LineWidth',2);
    %saettigungsAlgo
    calculatedHeightSaettigungsAlgo = saettigungsAlgo(croppedUndistortedImages{img});
    figure, imshow(croppedUndistortedImages{img}), hold on;
    line([0 columns],[calculatedHeightSaettigungsAlgo calculatedHeightSaettigungsAlgo],'Color','g','LineWidth',2);
    figure, imshow(croppedMoreYellowImages{img}), hold on;
    line([0 columns],[calculatedHeightSaettigungsAlgo calculatedHeightSaettigungsAlgo],'Color','g','LineWidth',2);

    debugPoint = 0;
end



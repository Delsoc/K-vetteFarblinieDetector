init();

image = images{10};
%image = imread("newImage.jpg");
figure,imshow(image), hold on;
figure
image = makeMoreYellow(image); %TODO: should be done in init() or an extra prepare method
%figure,hold on, imshow(image);
image = undistortImage(image, cameraParams);
%figure,hold on, imshow(image);
stats = getBoundingBoxes(image); %TODO (noch sicherer): wenn 10 nicht erkannt werden sollten, dann solange weiter versuchen (mit anderen Bildern), bis 10 Objekte gefunden wurden
stats = adjustBoundingBoxes(stats);

croppedImages = cutKuevetten(image,stats);


for img=1 : length(croppedImages)
    %figure, hold on, imshow(croppedImages{img});
    [rows, columns, numberOfColorChannels] = size(croppedImages{img});
    calculatedHeight = houghAlgo(croppedImages{img});
    %figure, imshow(croppedImages{img}), hold on;
    %line([calculatedHeight 0],[calculatedHeight columns]);
    line([0 columns],[calculatedHeight calculatedHeight],'Color','r','LineWidth',2); 
    %plot(0,calculatedHeight,columns,calculatedHeight,'LineWidth',2);

    %%other algo
    calculatedHeightRedPlane = redplaneLineAlgo(croppedImages{img});
    debugPoint = 0;
end

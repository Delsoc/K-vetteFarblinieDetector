

croppedImages = cutKuevetten(images{1}, stats);
figure, hold on;
imshow(croppedImages{10});

croppedImages = cutKuevetten(images{12}, stats);
figure, hold on;
imshow(croppedImages{10});

%%%%

croppedImages = cutKuevetten(images{1}, stats);
figure, hold on;
imshow(croppedImages{1});

croppedImages = cutKuevetten(images{39}, stats);
figure, hold on;
imshow(croppedImages{1});

%%%%
for img=1: length(images)
    figure, hold on;
    imshow(images{img});
end
%%%%
for img=1 : length(images)
    croppedImages = cutKuevetten(images{img}, stats);
    
    figure, hold on;
    imshow(croppedImages{4});

    for k = 1 : length(croppedImages)
    %figure, hold on;
    %imshow(croppedImages{k});
    end
    
end
%%%%
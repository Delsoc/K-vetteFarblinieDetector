function [croppedImages] = cutKuevetten(RGB, stats)
    for k = 1 : length(stats)
        BB = stats(k).BoundingBox;
        %rectangle('Position', [BB(1),BB(2),BB(3),BB(4)],'EdgeColor','r','LineWidth',2);
        %figure;
        croppedImages{k} = imcrop(RGB, [BB(1) BB(2) BB(3) BB(4)]);
        %imshow(croppedImages{k});
    end
end
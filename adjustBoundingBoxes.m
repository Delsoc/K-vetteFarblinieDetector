function [stats] = adjustBoundingBoxes(stats, croppedUndistortedImages, imgNr)
    fn = fieldnames(stats);
    
    stepPerImageIndex = 0.02;

    for k=1:length(stats)
        curCroppedImg = croppedUndistortedImages{k};
        gray = im2gray(curCroppedImg);
        bw = im2bw(curCroppedImg, 0.3);
        [hoehe,breite] = size(bw);
        GwertLinie = bw(:,round(breite/2));

        indexes = find(GwertLinie == 1);
        [lastIndex,~] = size(indexes);
        KuevetteDecke = indexes(1,1);
        KuevetteBoden = indexes(lastIndex,1);
        %field(1)= linkester pixelstand (x1)
        %field(2)= oberster pixelstand (y1)
        %field(3)= breite
        %field(4)= höhe
        field = stats(k).(fn{1});
        field(1) = field(1) + (0.3 * field(3));
        field(3) = field(3) * 0.3;
        %field(4) = field(4) * 0.5;
        field(4) = (KuevetteBoden -2) * (0.6 - stepPerImageIndex*(imgNr-1));
        %field(2) = field(2) + field(4);
        field(2) = field(2) + (KuevetteBoden -2) * (1- (0.6 - stepPerImageIndex*(imgNr-1)));
        stats(k).(fn{1}) = field;
    end
end




%boundingBoxes{bb}(1)
%boundingBoxes{bb}(2)
%val3 = boundingBoxes{bb}(3);
%val4 = val3(1)  - 20;
%val4
%boundingBoxes{bb}(4)
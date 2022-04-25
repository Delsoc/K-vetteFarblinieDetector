function [stats] = adjustBoundingBoxes(stats)
    fn = fieldnames(stats);
    
    for k=1:length(stats)
        %field(1)= linkester pixelstand (x1)
        %field(2)= oberster pixelstand (y1)
        %field(3)= breite
        %field(4)= höhe
        field = stats(k).(fn{1});
        field(1) = field(1) + (0.3 * field(3));
        field(3) = field(3) * 0.3;
        field(4) = field(4) / 2;
        field(2) = field(2) + field(4);
        stats(k).(fn{1}) = field;
    end
end




%boundingBoxes{bb}(1)
%boundingBoxes{bb}(2)
%val3 = boundingBoxes{bb}(3);
%val4 = val3(1)  - 20;
%val4
%boundingBoxes{bb}(4)
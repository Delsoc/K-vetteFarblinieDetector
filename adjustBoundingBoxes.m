function [stats] = adjustBoundingBoxes(stats)
    fn = fieldnames(stats);
    
    for k=1:length(stats)
        field = stats(k).(fn{1});
        field(1) = field(1) + (0.3 * field(3));
        field(3) = field(3) * 0.3;
        stats(k).(fn{1}) = field;
    end
end




%boundingBoxes{bb}(1)
%boundingBoxes{bb}(2)
%val3 = boundingBoxes{bb}(3);
%val4 = val3(1)  - 20;
%val4
%boundingBoxes{bb}(4)
function [detectedHeight] = saettigungsAlgo(RGB)

    [H,S,V]=farbbioN(RGB);
    
    %figure,imshow(H), hold on;
    %figure,imshow(S), hold on;
    %figure,imshow(V), hold on;

    grayImg = im2gray(H);
    figure, imshow(grayImg);hold on;
    [hoehe,breite] = size(grayImg);
    GwertLinie = grayImg(:,round(breite/2));
    figure, plot(GwertLinie,'r','LineWidth',0.5), hold on;
    
    for i=60 : length(GwertLinie)
        copyGwertLinie(i-59,1) = GwertLinie(i,1);
    end

    try
        indexes = find(copyGwertLinie<copyGwertLinie(1:1)*0.6);
        detectedHeight = indexes(1:1)+60;
    catch
        detectedHeight = 0;
    end
end
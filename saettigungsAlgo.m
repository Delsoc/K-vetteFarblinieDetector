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
    
    try
        indexes = find(GwertLinie<GwertLinie(1:1)*0.6);
        detectedHeight = indexes(1:1);
    catch
        detectedHeight = 0;
    end
end
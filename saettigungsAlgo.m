function [detectedHeight] = saettigungsAlgo(RGB)
    [hoehe,~] = size(RGB);

    [H,S,V]=farbbioN(RGB);
    
    %figure,imshow(H), hold on;
    %figure,imshow(S), hold on;
    %figure,imshow(V), hold on;

    %grayImg = im2gray(S);
    bw = im2bw(S, 0.9);
    %%%figure, imshow(grayImg);hold on;
    [hoehe,breite] = size(bw);
    GwertLinie = bw(:,round(breite/2));
    %%%figure, plot(GwertLinie,'r','LineWidth',0.5), hold on;
    
    for i=80 : length(GwertLinie)
        copyGwertLinie(i-79,1) = GwertLinie(i,1);
    end

    % gut geeignet für 149 (ohne Gelbfilter und hoher Blasenkante)
    %for i=120 : length(GwertLinie)
    %    copyGwertLinie(i-119,1) = GwertLinie(i,1);
    %end

    try
        indexes = find(copyGwertLinie == 0);
        detectedHeight = indexes(1:1)+80;
        detectedHeight = hoehe - detectedHeight;
    catch
        detectedHeight = 0;
    end
end
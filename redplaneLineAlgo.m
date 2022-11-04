 function [calculatedHeight] = redplaneLineAlgo(RGB)
    %Rotkanal extrahieren
    %figure; hold on; imshow(RGB); 
    R = RGB(:,:,1);
    %image(R), colormap([[0:1/255:1]', zeros(256,1), zeros(256,1)]), colorbar;
    %%%figure; hold on; imshow(R); 


    %test linescan
    %figure, imshow(R);hold on;
    [hoehe,breite] = size(R);
    GwertLinie = R(:,round(breite/2));

    try
        indexes = find(GwertLinie < 25);
        calculatedHeight = indexes(1:1);
        calculatedHeight = hoehe - calculatedHeight;
    catch
        calculatedHeight = 0;
    end
end







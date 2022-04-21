function [calculatedHeight] = redplaneLineAlgo(RGB)
    [rows, columns, numberOfColorChannels] = size(RGB);
    %Rotkanal extrahieren
    R = RGB(:,:,1);
    %image(R), colormap([[0:1/255:1]', zeros(256,1), zeros(256,1)]), colorbar;
    %%figure; hold on; imshow(R); 

    %schwarz-weiß Bild
    bw = im2bw(R, 0.3);
    figure; hold on; imshow(bw);
    
    y = rows;
    value = 0;
    x1 = round(0.5 * columns);
    x2 = round(0.4 * columns);
    x3 = round(0.6 * columns);
    while(value < 1)
        y = y - 1;
        value = 0;
        value = value + bw(y,x1);
        value = value + bw(y,x2);
        value = value + bw(y,x3);
    end
    calculatedHeight = y;
end







function [calculatedHeight] = houghAlgo3(RGB)
    [rows, columns, numberOfColorChannels] = size(RGB);
    %figure, hold on;
    %converting image to BW
    %RGB= imread("altGelbFilterEineKüvette.jpg");
    
    %X = imread('altGelbFilterEineKüvette.jpg');
    
    Img2 = RGB;
    %Img2 = imbinarize(Img2);
    %BW = imcomplement(Img2);
    %figure, hold on, imshow(BW);
    %BW = Img2;
    %%%imshow(BW);
    %Bimage = im2bw(Img2, 0.8); %%0.8 interessant
    Bimage = imcomplement(Img2);
    %figure, hold on, imshow(Bimage);
    BW = edge(Bimage,'prewitt');
    %figure, hold on, imshow(Bimage);
    point = 2;
    %%%imshow(Bimage);
    %figure;
    %%
    [H, theta, rho] = hough(BW);
    %imshow(imadjust(rescale(H)),'XData',theta,'YData',rho, 'InitialMagnification','fit');
    %axis on, axis normal, hold on;
    %colormap(gca,hot);
    
    %% 
    %applying threshold to find points on lines
    P = houghpeaks(H,3,'threshold',ceil(0.5*max(H(:))));
    x = theta(P(:,2));
    y = rho(P(:,1));
    lines = houghlines(BW, theta, rho, P, 'FillGap',6,'MinLength',4);
    figure, imshow(RGB), hold on;
    max_len = 0;
    calculatedHeight = 0;
    countedHeightPoints = 0;
    for k = 1:length(lines)
        xy = [lines(k).point1; lines(k).point2];
       
        % Plot beginnings and ends of lines
        
        y1 = xy(1,2);
        y2 = xy(2,2);
        lineFocusWeight = (y1 + y2)/2;
        plot(xy(:,1),xy(:,2),'LineWidth',2);
        if (lineFocusWeight < (0.85 * rows) && lineFocusWeight > (0.25) * rows)
            calculatedHeight = calculatedHeight + lineFocusWeight;
            countedHeightPoints = countedHeightPoints + 1; 
            plot(xy(:,1),xy(:,2),'LineWidth',2);
        end

        plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
        plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color', 'red');
    
        len = norm(lines(k).point1 - lines(k).point2);
       if ( len > max_len)
          max_len = len;
          xy_long = xy;
       end
    end
    
    if(calculatedHeight > 0)
        calculatedHeight = calculatedHeight / countedHeightPoints;
    end
end










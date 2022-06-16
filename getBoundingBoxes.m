function [stats,centroids] = cutKuevetten(RGB)
    %threshold = 0.06; %getestet
    threshold = 0.07; %getestet

    %--read image in RGB
    %%%imshow(RGB);
    %figure;

    % convert the image to black and white in order to prepare
    % for boundary tracing using |bwboundaries| 
    I = rgb2gray(RGB);
    bw = imbinarize(I, threshold );
    %%%imshow(bw);
    %figure;
    
    %remove all objects containing fewer than 300 pixels
    bw = bwareaopen(bw,300);
    %%%imshow(bw);
    %figure;
    
    %fill a gap in the pen's cap
    se = strel('disk',9); %wenn ich hier den Wert auf 180 mache, dann kriege ich den ganzen Bereich, der mich interessiert als weißen Block
    bw = imclose(bw, se);
    %%%figure, hold on;
    %%%imshow(bw);
    %figure;
    
    % fill any holes, so that regionprops used to estimate the area
    % enclosed by each of the boundaries
    bw = imfill(bw, 'holes');
    %%%figure, hold on;
    %%%imshow(bw);
    %figure;

    % B has the pixelvalues of the boundaries of all the objects
    % L has the pixelvalues of the boundaries INCLUDING what is inside the
    % boundaries
    [B,L] = bwboundaries(bw, 'noholes');
    %%%imshow(label2rgb(L,@jet,[.5 .5 .5]));
    %%%hold on
    for k=1:length(B)
        boundary = B{k};
        %plot(boundary(:,2), boundary(:,1), 'w', 'LineWidth', 1)
    end
    %figure;
    
    [bwLabel,num] = bwlabel(bw,8);
    stats = regionprops(bwLabel, 'BoundingBox');
    centroids = regionprops(bw,'centroid');

    %%%imshow(RGB);
    %hold on;
end
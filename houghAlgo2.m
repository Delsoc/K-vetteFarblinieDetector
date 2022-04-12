% read an image file
filename = "gelb_adjust.jpg";
    I  = imread(filename);
    info = imfinfo(filename, 'jpg');
    % if the image is a color image, we need to convert it to grayscale
    if (strcmp(info,'truecolor') + strcmp(info, 'indexed')) > 0
        I = histeq(rgb2gray(I));
    end;
    thresh = graythresh(I);
    Bimage = im2bw(I, thresh);
    Bimage = edge(Bimage,'canny');
    [H, T, R] = hough(Bimage);%,'RhoResolution',0.1,'Theta',[-90,0]);
    %[H,T,R] = hough(Bimage);
    imshow(H,[],'XData', T, 'YData', R, 'InitialMagnification', 'fit');
    xlabel('\theta'), ylabel('\rho');
    axis on, axis normal, hold on;
    P  = houghpeaks(H,10);%,'threshold',ceil(0.3*max(H(:))));
    x = T(P(:,2)); y = R(P(:,1));
    plot(x,y,'o','color','red');
    % Find lines and plot them
    lines = houghlines(Bimage,T,R,P)%,'FillGap',100,'MinLength',5);
    figure, imshow(I), hold on
    max_len = 0;
    for k = 1:length(lines)
        xy = [lines(k).point1; lines(k).point2];
        plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');
        % Plot beginnings and ends of lines
        plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
        plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');
        % Determine the endpoints of the longest line segment
        len = norm(lines(k).point1 - lines(k).point2);
        if ( len > max_len)
            max_len = len;
            xy_long = xy;
        end
    end
    % highlight the longest line segment
    plot(xy_long(:,1),xy_long(:,2),'LineWidth',2,'Color','blue');
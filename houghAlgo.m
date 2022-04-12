close all;
%converting image to BW
RGB= imread("gelb_eineKüvette4.jpg");
Img = RGB;

X = imread('gelb_eineKüvette4.jpg');
R = X(:,:,1);
image(R), colormap([[0:1/255:1]', zeros(256,1), zeros(256,1)]), colorbar;
imshow(R); figure;

Img2 = R;
Img2 = imbinarize(Img2);
BW = imcomplement(Img2);
%BW = Img2;
imshow(BW);
Bimage = im2bw(Img2, 0.3); %%0.8 interessant
Bimage = imcomplement(Bimage);
BW = edge(Bimage,'canny');
imshow(Bimage);
figure;
%%
[H, theta, rho] = hough(BW);
imshow(imadjust(rescale(H)),'XData',theta,'YData',rho,...
    'InitialMagnification','fit');
axis on, axis normal, hold on;
colormap(gca,hot);

%% 
%applying threshold to find points on lines
P = houghpeaks(H,100,'threshold',ceil(0.2*max(H(:))));
x = theta(P(:,2));
y = rho(P(:,1));
lines = houghlines(BW, theta, rho, P, 'FillGap',3,'MinLength',4);
figure, imshow(RGB),
hold on
max_len = 0;
for k = 1:length(lines)
    xy = [lines(k).point1; lines(k).point2];
    plot(xy(:,1),xy(:,2),'LineWidth',2);
    % Plot beginnings and ends of lines
    plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
    plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color', 'red');

    len = norm(lines(k).point1 - lines(k).point2);
   if ( len > max_len)
      max_len = len;
      xy_long = xy;
   end
end









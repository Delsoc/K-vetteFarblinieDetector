function GwertliniePlotten(croppedUndistortedImages)
    
    for img=1 : length(croppedUndistortedImages)
        %figure, hold on, imshow(croppedUndistortedImages{img});
        redplane = croppedUndistortedImages{img}(:,:,1);
        bw = im2bw(redplane, 0.32);
        figure, hold on, imshow(redplane);
        figure, hold on, imshow(bw);

        [hoehe,breite] = size(croppedUndistortedImages{img});
        GwertLinie = croppedUndistortedImages{img}(:,round(breite/2));
        for i=80 : length(GwertLinie)-40
        GwertLinie2(i-79,1) = GwertLinie(i,1);
        end
        data = double(GwertLinie2);
        FX = gradient(data);
        %figure, plot(FX,'r','LineWidth',0.5), hold on;
        %figure, plot(GwertLinie,'r','LineWidth',0.5), hold on;
        
    end

end
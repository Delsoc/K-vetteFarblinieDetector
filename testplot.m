figure;

% Top two plots

tiledlayout(2,2)
nexttile
imshow(croppedUndistortedImages{1});
title('Plot 1');
nexttile
imshow(croppedUndistortedImages{1});
title('Plot 1');
% Plot that spans
nexttile([1 2])
imshow(croppedUndistortedImages{1});
title('Plot 1');
line([0 columns],[calculatedHeightSaettigungsAlgo calculatedHeightSaettigungsAlgo],'Color','g','LineWidth',2);
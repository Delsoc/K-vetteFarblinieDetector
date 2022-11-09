function calcAndSafeInExcel(numImages,durationBetweenImagesInSek)
    %The position of all components required for photography are fixed at
    %all times! the length of 1 pixel was evaluated: 93px = 7mm = 7000µm.
    %1px = 0,075mm = 75000µm

    detectedLineHeightMatrixHough = matfile('detectedLineHeightMatrixHough.mat').detectedLineHeightMatrixHough;
    detectedLineHeightMatrixRedPlane = matfile('detectedLineHeightMatrixRedPlane.mat').detectedLineHeightMatrixRedPlane;
    detectedLineHeightMatrixSaettigung = matfile('detectedLineHeightMatrixSaettigung.mat').detectedLineHeightMatrixSaettigung;
    completeKuevettenHeight = matfile('completeKuevettenHeight.mat').completeKuevettenHeight;

    row = 1;
    pixelToMillimeter = 0.0681;
    pixelToMikrometer = 68100;
    
    lineMovement = 0;

    filename = 'results.xlsx';
    delete(filename);
    saveInExcelColumns = ["D", "O", "Z", "AK", "AV", "BG", "BR", "CC", "CN", "CY"];
    titleColumns = ["I", "T", "AE", "AP", "BA", "BL", "BW", "CH", "CS", "DD"];
    resultsMatrix = {};
    
    for imgIndex=1:numImages
        %alle Bilder durchgehen
        for kuevetteIndex=1:10
            %alle Kuevetten durchgehen
            resultsKuevette = zeros([3,9]);
            completeHeight = completeKuevettenHeight(imgIndex,kuevetteIndex); %in px
            %Hough
            currentHeightHoughInPixel = detectedLineHeightMatrixHough(imgIndex,kuevetteIndex);
            resultsKuevette(1,1) = currentHeightHoughInPixel; %höhe [px]
            resultsKuevette(1,2) = currentHeightHoughInPixel * pixelToMikrometer; %höhe [µm]
            resultsKuevette(1,3) = currentHeightHoughInPixel * pixelToMillimeter; %höhe [mm]
            resultsKuevette(1,9) = (currentHeightHoughInPixel / completeHeight) * 100; %höhe [%]

            %redplane
            currentHeightRedplaneInPixel = detectedLineHeightMatrixRedPlane(imgIndex,kuevetteIndex);
            resultsKuevette(2,1) = currentHeightRedplaneInPixel; %höhe [px]
            resultsKuevette(2,2) = currentHeightRedplaneInPixel * pixelToMikrometer; %höhe [µm]
            resultsKuevette(2,3) = currentHeightRedplaneInPixel * pixelToMillimeter; %höhe [mm]
            resultsKuevette(2,9) = (currentHeightRedplaneInPixel / completeHeight) * 100; %höhe [%]

            %saettigung
            currentHeightSaettigungInPixel = detectedLineHeightMatrixSaettigung(imgIndex,kuevetteIndex);
            resultsKuevette(3,1) = currentHeightSaettigungInPixel; %höhe [px]
            resultsKuevette(3,2) = currentHeightSaettigungInPixel * pixelToMikrometer; %höhe [µm]
            resultsKuevette(3,3) = currentHeightSaettigungInPixel * pixelToMillimeter; %höhe [mm]
            resultsKuevette(3,9) = (currentHeightSaettigungInPixel / completeHeight) * 100; %höhe [%]

            if(imgIndex~=1)
                %Hough
                lastResultsForThisKuevetteHough = resultsMatrix{imgIndex-1,kuevetteIndex};
                lastHeightHoughInPixel = lastResultsForThisKuevetteHough(1,1);
                linienwanderungHoughPixel = lastHeightHoughInPixel - currentHeightHoughInPixel;
                resultsKuevette(1,4) = linienwanderungHoughPixel; %Linienwanderung [px]
                resultsKuevette(1,5) = linienwanderungHoughPixel * pixelToMikrometer; %Linienwanderung [µm]
                resultsKuevette(1,6) = linienwanderungHoughPixel * pixelToMillimeter; %Linienwanderung [mm]
                resultsKuevette(1,7) = (linienwanderungHoughPixel * pixelToMikrometer) / durationBetweenImagesInSek; %Geschwindigkeit[µm/sek]
                resultsKuevette(1,8) = (linienwanderungHoughPixel * pixelToMillimeter) / durationBetweenImagesInSek; %Geschwindigkeit[mm/sek]

                %redplane
                lastResultsForThisKuevetteRedplane = resultsMatrix{imgIndex-1,kuevetteIndex};
                lastHeightRedplaneInPixel = lastResultsForThisKuevetteRedplane(2,1);
                linienwanderungRedplanePixel = lastHeightRedplaneInPixel - currentHeightRedplaneInPixel;
                resultsKuevette(2,4) = linienwanderungRedplanePixel; %Linienwanderung [px]
                resultsKuevette(2,5) = linienwanderungRedplanePixel * pixelToMikrometer; %Linienwanderung [µm]
                resultsKuevette(2,6) = linienwanderungRedplanePixel * pixelToMillimeter; %Linienwanderung [mm]
                resultsKuevette(2,7) = (linienwanderungRedplanePixel * pixelToMikrometer) / durationBetweenImagesInSek; %Geschwindigkeit[µm/sek]
                resultsKuevette(2,8) = (linienwanderungRedplanePixel * pixelToMillimeter) / durationBetweenImagesInSek; %Geschwindigkeit[mm/sek]

                %saettigung
                lastResultsForThisKuevetteSaettigung = resultsMatrix{imgIndex-1,kuevetteIndex};
                lastHeightSaettigungInPixel = lastResultsForThisKuevetteSaettigung(3,1);
                linienwanderungSaettigungPixel = lastHeightSaettigungInPixel - currentHeightSaettigungInPixel;
                resultsKuevette(3,4) = linienwanderungSaettigungPixel; %Linienwanderung [px]
                resultsKuevette(3,5) = linienwanderungSaettigungPixel * pixelToMikrometer; %Linienwanderung [µm]
                resultsKuevette(3,6) = linienwanderungSaettigungPixel * pixelToMillimeter; %Linienwanderung [mm]
                resultsKuevette(3,7) = (linienwanderungSaettigungPixel * pixelToMikrometer) / durationBetweenImagesInSek; %Geschwindigkeit[µm/sek]
                resultsKuevette(3,8) = (linienwanderungSaettigungPixel * pixelToMillimeter) / durationBetweenImagesInSek; %Geschwindigkeit[mm/sek]

            else
                %Hough
                resultsKuevette(1,4) = 0; %Linienwanderung [px]
                %redplane
                resultsKuevette(2,4) = 0; %Linienwanderung [px]
                %redplane
                resultsKuevette(3,4) = 0; %Linienwanderung [px]
            end
            resultsMatrix{imgIndex,kuevetteIndex} = resultsKuevette;
        end
    end

    %%saved all calculated values in resultsMatrix
    %%TODO: write Excel
     for imgIndex=1:numImages
        %alle 12 Bilder durchgehen
    
        for kuevetteIndex=1:10
            %alle Kuevetten durchgehen
            kuevetteResults = resultsMatrix{imgIndex,kuevetteIndex};
    
            columnTitles = ["höhe [px]", "höhe [µm]", "höhe [mm]", "Linienwanderung [px]", "Linienwanderung [µm]", "Linienwanderung [mm]", "Geschwindigkeit[µm/sek]", "Geschwindigkeit[mm/sek]", "höhe[%]"];
            imageTitle = strcat("Image ",num2str(imgIndex));
            rowTitles = ["HoughAlgo", "RedPlaneAlgo","heightSaettigungsAlgo"];
            rowTitles = transpose(rowTitles);
    
            writematrix(columnTitles,filename,'Sheet',1,'Range', strcat(saveInExcelColumns(kuevetteIndex),num2str(row)));
            writematrix(imageTitle,filename,'Sheet',1,'Range', strcat('A',num2str(row)));
            writematrix(rowTitles,filename,'Sheet',1,'Range',strcat('A',num2str(row+1),':A',num2str(row+3)));
            %writematrix(kuevetteResults,filename,'Sheet',1,'Range', strcat('D',num2str(row+1)));
            writematrix(kuevetteResults,filename, 'Sheet',1,'Range', strcat(saveInExcelColumns(kuevetteIndex),num2str(row+1)));
    
        end
        disp("- excel schreiben ...");
        row = row+5;
     end
    
    disp("- endlich fertig! Viel Spaß mit Ihrer results.xlsx");
    
end
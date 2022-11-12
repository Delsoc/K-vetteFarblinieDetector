function calcAndSafeInExcel(numImages,durationBetweenImagesInSek)
    % Diese Funktion erwartet als Eingabe die Anzahl der Bilder in dem
    % Versuchordner, sowie die Anzahl der Sekunden zwischen den
    % Bildaufnahmen. Diese Funktion wertet die detektierten Höhen aus bzw.
    % rechnet die um und erstellt eine Excel-Tabelle, in der die Ergebnisse
    % enthalten sind. Für jede Küvette wird die Höhe in [px], [µm], [mm] und
    % [%] angegeben. Außerdem wird die Linienwanderung berechnet in [px],
    % [µm], [mm], sowie die Geschwindigkeit der Linienwanderung in [µm/sek]
    % und [mm/sek]

    % Die Matrizen, die die ermittelten Höhen der jeweiligen Alogrithmen
    % werden geladen, sowie die Matrix, die die gesamten Küvettenhöhen
    % enthaltet
    detectedLineHeightMatrixHough = matfile('detectedLineHeightMatrixHough.mat').detectedLineHeightMatrixHough;
    detectedLineHeightMatrixRedPlane = matfile('detectedLineHeightMatrixRedPlane.mat').detectedLineHeightMatrixRedPlane;
    detectedLineHeightMatrixSaettigung = matfile('detectedLineHeightMatrixSaettigung.mat').detectedLineHeightMatrixSaettigung;
    completeKuevettenHeight = matfile('completeKuevettenHeight.mat').completeKuevettenHeight;

    % row ist die aktuelle Excel-Zeile und wird erstmal mit 1
    % initialisiert.
    row = 1;

    % Umrechnungsfaktor von Pixel zu Millimeter und von Pixel zu Mikrometer
    % festlegen
    pixelToMillimeter = 0.0681;
    pixelToMikrometer = 68100;

    % Filename der Exceldatei festlegen
    filename = 'results.xlsx';

    % Falls diese Datei schon vorhanden ist, dann erstmal löschen
    delete(filename);

    % Die Startspalten in Excel festlegen für die einzelnen
    % Küvettenergebnisse
    saveInExcelColumns = ["D", "O", "Z", "AK", "AV", "BG", "BR", "CC", "CN", "CY"];
    
    % Eine resultsMatrix erstellen
    resultsMatrix = {};
    
    % Über die Bilder iterieren
    for imgIndex=1:numImages

        % Über die Küvetten iterieren
        for kuevetteIndex=1:10

            % 3x9-Ergebnisküvettenmatrix erstellen für eine Küvette. Diese Matrix 
            % besteht aus 3 Zeilen und 9 Spalten. Jede Zeile steht für die
            % Ergebnisse eines Algorithmus für die jeweilige Küvette. Die
            % Spalten stehen für die unterschiedlichen Ergebnisse für die
            % Küvette
            resultsKuevette = zeros([3,9]);

            % die komplette Höhe der aktuellen Küvette auslesen
            completeHeight = completeKuevettenHeight(imgIndex,kuevetteIndex); %in px
            
            % Hough
            % die detektierte Linienhöhe für diese Küvette auslesen
            currentHeightHoughInPixel = detectedLineHeightMatrixHough(imgIndex,kuevetteIndex);
            
            % Die Ergebnisshöhen für die Küvette für das Verfahren 
            % "Hough-Transformation" berechnen und in der
            % Ergebnisküvettenmatrix speichern
            resultsKuevette(1,1) = currentHeightHoughInPixel; %höhe [px]
            resultsKuevette(1,2) = currentHeightHoughInPixel * pixelToMikrometer; %höhe [µm]
            resultsKuevette(1,3) = currentHeightHoughInPixel * pixelToMillimeter; %höhe [mm]
            resultsKuevette(1,9) = (currentHeightHoughInPixel / completeHeight) * 100; %höhe [%]

            %Rotkanal
            % die detektierte Linienhöhe für diese Küvette auslesen
            currentHeightRedplaneInPixel = detectedLineHeightMatrixRedPlane(imgIndex,kuevetteIndex);
            
            % Die Ergebnisshöhen für die Küvette für das Verfahren 
            % "Extraktion des Rotkanals" berechnen und in der
            % Ergebnisküvettenmatrix speichern
            resultsKuevette(2,1) = currentHeightRedplaneInPixel; %höhe [px]
            resultsKuevette(2,2) = currentHeightRedplaneInPixel * pixelToMikrometer; %höhe [µm]
            resultsKuevette(2,3) = currentHeightRedplaneInPixel * pixelToMillimeter; %höhe [mm]
            resultsKuevette(2,9) = (currentHeightRedplaneInPixel / completeHeight) * 100; %höhe [%]

            %Sättigung
            % die detektierte Linienhöhe für diese Küvette auslesen
            currentHeightSaettigungInPixel = detectedLineHeightMatrixSaettigung(imgIndex,kuevetteIndex);
            
            % Die Ergebnisshöhen für die Küvette für das Verfahren 
            % "Extraktion des Sättigungskanals" berechnen und in der
            % Ergebnisküvettenmatrix speichern
            resultsKuevette(3,1) = currentHeightSaettigungInPixel; %höhe [px]
            resultsKuevette(3,2) = currentHeightSaettigungInPixel * pixelToMikrometer; %höhe [µm]
            resultsKuevette(3,3) = currentHeightSaettigungInPixel * pixelToMillimeter; %höhe [mm]
            resultsKuevette(3,9) = (currentHeightSaettigungInPixel / completeHeight) * 100; %höhe [%]

            if(imgIndex~=1)
                % Linienwanderungen und Geschwindigkeiten berechnen

                % Hough
                % Letzte Pixelhöhe der Linie der Küvette auslesen
                lastResultsForThisKuevetteHough = resultsMatrix{imgIndex-1,kuevetteIndex};
                lastHeightHoughInPixel = lastResultsForThisKuevetteHough(1,1);
                
                % Linienwanderung und Geschwindigkeit berechnen für diese
                % Küvette für den Hough-Algorithmus und in
                % Ergebnisküvettenmatrix speichern
                linienwanderungHoughPixel = lastHeightHoughInPixel - currentHeightHoughInPixel;
                resultsKuevette(1,4) = linienwanderungHoughPixel; %Linienwanderung [px]
                resultsKuevette(1,5) = linienwanderungHoughPixel * pixelToMikrometer; %Linienwanderung [µm]
                resultsKuevette(1,6) = linienwanderungHoughPixel * pixelToMillimeter; %Linienwanderung [mm]
                resultsKuevette(1,7) = (linienwanderungHoughPixel * pixelToMikrometer) / durationBetweenImagesInSek; %Geschwindigkeit[µm/sek]
                resultsKuevette(1,8) = (linienwanderungHoughPixel * pixelToMillimeter) / durationBetweenImagesInSek; %Geschwindigkeit[mm/sek]

                %Rotkanal
                % Letzte Pixelhöhe der Linie der Küvette auslesen
                lastResultsForThisKuevetteRedplane = resultsMatrix{imgIndex-1,kuevetteIndex};
                lastHeightRedplaneInPixel = lastResultsForThisKuevetteRedplane(2,1);

                % Linienwanderung und Geschwindigkeit berechnen für diese
                % Küvette für den Rotkanal-Algorithmus und in
                % Ergebnisküvettenmatrix speichern
                linienwanderungRedplanePixel = lastHeightRedplaneInPixel - currentHeightRedplaneInPixel;
                resultsKuevette(2,4) = linienwanderungRedplanePixel; %Linienwanderung [px]
                resultsKuevette(2,5) = linienwanderungRedplanePixel * pixelToMikrometer; %Linienwanderung [µm]
                resultsKuevette(2,6) = linienwanderungRedplanePixel * pixelToMillimeter; %Linienwanderung [mm]
                resultsKuevette(2,7) = (linienwanderungRedplanePixel * pixelToMikrometer) / durationBetweenImagesInSek; %Geschwindigkeit[µm/sek]
                resultsKuevette(2,8) = (linienwanderungRedplanePixel * pixelToMillimeter) / durationBetweenImagesInSek; %Geschwindigkeit[mm/sek]

                %saettigung
                % Letzte Pixelhöhe der Linie der Küvette auslesen
                lastResultsForThisKuevetteSaettigung = resultsMatrix{imgIndex-1,kuevetteIndex};
                lastHeightSaettigungInPixel = lastResultsForThisKuevetteSaettigung(3,1);

                % Linienwanderung und Geschwindigkeit berechnen für diese
                % Küvette für den Sättigung-Algorithmus und in
                % Ergebnisküvettenmatrix speichern
                linienwanderungSaettigungPixel = lastHeightSaettigungInPixel - currentHeightSaettigungInPixel;
                resultsKuevette(3,4) = linienwanderungSaettigungPixel; %Linienwanderung [px]
                resultsKuevette(3,5) = linienwanderungSaettigungPixel * pixelToMikrometer; %Linienwanderung [µm]
                resultsKuevette(3,6) = linienwanderungSaettigungPixel * pixelToMillimeter; %Linienwanderung [mm]
                resultsKuevette(3,7) = (linienwanderungSaettigungPixel * pixelToMikrometer) / durationBetweenImagesInSek; %Geschwindigkeit[µm/sek]
                resultsKuevette(3,8) = (linienwanderungSaettigungPixel * pixelToMillimeter) / durationBetweenImagesInSek; %Geschwindigkeit[mm/sek]

            else
                % Wenn die Küvette dem ersten Bild zugeordnet ist, wird die
                % Linienwanderung für die jeweiligen Algorithmen auf 0
                % gesetzt

                %Hough
                resultsKuevette(1,4) = 0; %Linienwanderung [px]
                %Rotkanal
                resultsKuevette(2,4) = 0; %Linienwanderung [px]
                %Sättigung
                resultsKuevette(3,4) = 0; %Linienwanderung [px]
            end
            % Die erstellte Ergebnissmatrix für die Küvette wird als eine
            % Zelle in der gesamten Ergebnismatrix gespeichert.
            resultsMatrix{imgIndex,kuevetteIndex} = resultsKuevette;
        end
    end

    % Zu diesem Zeitpunkt sind alle Ergebnisse in der Ergebnismatrix
    % gespeichert und als nächstes wird die Excel-Datei erstellt

    % über alle Bilder iterieren
     for imgIndex=1:numImages
        
        % über alle Küvetten iterieren
        for kuevetteIndex=1:10
            
            % Küvettenergebnisse laden
            kuevetteResults = resultsMatrix{imgIndex,kuevetteIndex};
    
            % Titel für die Spalten der Küvettenergebnisse in Excel
            % festgelegt
            columnTitles = ["höhe [px]", "höhe [µm]", "höhe [mm]", "Linienwanderung [px]", "Linienwanderung [µm]", "Linienwanderung [mm]", "Geschwindigkeit[µm/sek]", "Geschwindigkeit[mm/sek]", "höhe[%]"];
            
            % Bildtitel erstellen für die Excel-Datei
            imageTitle = strcat("Image ",num2str(imgIndex));
            
            % Titel der Zeilen für die jeweiligen Algorithmen festgelegt
            rowTitles = ["HoughAlgo", "RedPlaneAlgo","heightSaettigungsAlgo"];
            rowTitles = transpose(rowTitles);
    
            % Ergebnisse und alle festgelegt Titel in die Exceldatei
            % speichern
            writematrix(columnTitles,filename,'Sheet',1,'Range', strcat(saveInExcelColumns(kuevetteIndex),num2str(row)));
            writematrix(imageTitle,filename,'Sheet',1,'Range', strcat('A',num2str(row)));
            writematrix(rowTitles,filename,'Sheet',1,'Range',strcat('A',num2str(row+1),':A',num2str(row+3)));
            writematrix(kuevetteResults,filename, 'Sheet',1,'Range', strcat(saveInExcelColumns(kuevetteIndex),num2str(row+1)));
    
        end
        % Dem Benutzer ausgeben, dass in die Exceldatei geschrieben wird
        disp("- excel schreiben ...");

        % Die row um 5 Zeilen inkrementieren
        row = row+5;
     end
    
     % Dem Benutzer anzeigen, dass die Ausführung vollendet ist
    disp("- endlich fertig! Viel Spaß mit Ihrer results.xlsx");
    
end
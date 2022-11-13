% Init.m
% Dieser File initialisiert die Anwendung. 
% - Der Benutzer wird nach notwendigen Informationen abgefragt, 
% um die Anwendung zu starten.
% - Die Bilder werden chronologisch ausgelesen
% - Die Matrizen werden initialisiert, in denen die ermittelten Höhen
% zwischengespeichert werden, sowie die Gesamthöhe einer ausgeschnittenen
% Küvette


% Zu Beginn wird der Workspace geleert und alle offene Figures geschlossen
clear;
close all;

% Kameraparameter für die Entzerrung werden geladen
load cameraParams.mat;

% definiert, in welchem Ordner sich die Versuchsordner befinden
versuchsbilderOrdnerName = "Versuchsbilder\";

% der Benutzer wird nach der Nummer des Versuchsordners gefragt, für den
% die Auswertung stattfinden soll. Die Nummer wird zwischengespeichert.
prompt = "Mit welcher Nummer fängt der Ordner an, der die Versuchsbilder beinhaltet? ";
folderNumber = input(prompt,"s");

% der Benutzer wird nach der Nummer des Bildes gefragt, in der die Küvette 
% enthalten ist, die die Küvette enthält, für die die Auswertungsschritte 
% der verschiedenen Verfahren angezeigt werden sollen. 
% Die Nummer wird zwischengespeichert.
prompt = "In welchem Bild befindet sich die Küvette, dessen " + ...
    "Zwischenschritte in den Algorithmen angezeigt werden sollen? (Nummer eingeben..) ";
imageNumber = str2num(input(prompt,"s"));

% der Benutzer wird nach der Nummer der Küvette im Bild gefragt für die die 
% Auswertungsschritte der verschiedenen Verfahren angezeigt werden sollen. 
% Die Nummer wird zwischengespeichert.
prompt = "Für welche Küvette in dem Bild sollen die Zwischenschritte in den " + ...
    "Algorithmen angezeigt werden? (Nummer eingeben von 1 bis 10) ";
kuevetteNumber = str2num(input(prompt,"s"));

try
    % Der gewünschte Versuchsordner wird gesucht und in folderFiles
    % zwischengespeichert
    folderFiles = dir(append(versuchsbilderOrdnerName,folderNumber,' ','*'));
    length(folderFiles.name);
    
    % Die Informationen aus dem Namen des Versuchsordners werden in
    % expInfos zwischengespeichert. expInfos beinhaltet 
    % ["Versuchsordnernummer", "Abstände der Bilder in sek", "Anzahl der Bilder"]
    expInfos =  strsplit(folderFiles.name); 

    % Im Kommandofenster ausgegeben, welcher Ordner gefunden wurde
    disp(append(" - Ordner '",folderFiles.name, "' gefunden"));

catch
    % Falls der Ordner nicht gefunden werden konnte, wird dem Benutzer dies
    % mitgeteilt und die Anwendung beendet.
    disp(append("ERROR: Ein Fehler ist aufgetreten. Sicher, dass der Ordner, mit der Startnummer '", folderNumber, "' ", "im Ordner 'Versuchsbilder' existiert?"));
    return;

end

try
    % es wird versucht die Bilderfiles in dem gefundenen Ordner auszulesen und
    % in imagefiles zu speichern.
    imagefiles = dir(append(versuchsbilderOrdnerName,folderFiles.name,'\*.jpg'));    
    
    % Die Anzahl der gefunden Bilder wird zwischengespeichert
    nfiles = length(imagefiles);
    
    % Die Bilderfiles werden chronologisch sortiert
    [~, reindex] = sort( str2double( regexp( {imagefiles.name}, '\d+', 'match', 'once' )));
    imagefiles = imagefiles(reindex);
    
    % Über alle gefundenen Bilderfiles iterieren
    for ii=1:nfiles
       
       % Bildname des aktuellen Bildfiles zwischenspeichern
       currentfilename = imagefiles(ii).name;

       % aktuelle Bild aus dem Ordner auslesen und in currentimage
       % zwischenspeichern
       currentimage = imread(append(versuchsbilderOrdnerName,folderFiles.name,'\',currentfilename));
       
       % das aktuelle Bild in die Bildsammlung "images" speichern
       images{ii} = currentimage;
    end

    % Dem Benutzer ausgeben, wie viele Bilder gefunden wurden.
    disp(append(" - ", num2str(nfiles), " Bilder wurden gefunden."));
catch
    % Falls beim lesen der Bilder ein Fehler aufgetreten ist, dem Benutzer
    % drüber informieren und die Anwendung beenden
    disp("ERROR: Es ist ein Fehler beim lesen der Bilder aufgetreten");
    return;
end

% Je Algorithmus eine Matrix erstellen und mit 0 initialisieren, in denen
% im Laufe der Anwendung die ermittelten Höhen der Algorithmen gespeichert
% werden
detectedLineHeightMatrixHough = zeros([length(imagefiles),10]);
detectedLineHeightMatrixRedPlane = zeros([length(imagefiles),10]);
detectedLineHeightMatrixSaettigung = zeros([length(imagefiles),10]);

% Matrix erstellen und mit 0 initialisieren, in der im laufe der Anwendung
% die Gesamthöhe der detektierten Küvetten gespeichert werden.
completeKuevettenHeight = zeros([length(imagefiles),10]);

% Alle Matrizen in jeweils einem .mat-File speichern
save('completeKuevettenHeight.mat','completeKuevettenHeight');
save('detectedLineHeightMatrixHough.mat','detectedLineHeightMatrixHough');
save('detectedLineHeightMatrixRedPlane.mat','detectedLineHeightMatrixRedPlane');
save('detectedLineHeightMatrixSaettigung.mat','detectedLineHeightMatrixSaettigung');

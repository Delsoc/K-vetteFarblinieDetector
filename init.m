clear;
close all;

% load camera parameter for undistortion
load cameraParams.mat;


%fixed parameters
folderNameLastPart = "29.01.2022-18%3A27";
versuchsbilderOrdnerName = "Versuchsbilder\";

%query folderNumber
prompt = "Mit welcher Nummer fängt der Ordner an, der die Versuchsbilder beinhaltet? ";
folderNumber = input(prompt,"s");
try
    folderFiles = dir(append(versuchsbilderOrdnerName,folderNumber,' ','*'));
    length(folderFiles.name);
    disp(append(" - Ordner '",folderFiles.name, "' gefunden"));
catch
    disp(append("ERROR: Ein Fehler ist aufgetreten. Sicher, dass der Ordner, mit der Startnummer '", folderNumber, "' ", "im Ordner 'Versuchsbilder' existiert?"));
    return;
end

%read images
try
    imagefiles = dir(append(versuchsbilderOrdnerName,folderFiles.name,'\*.jpg'));    
    nfiles = length(imagefiles);    % Number of files found
    %sort Images
    [~, reindex] = sort( str2double( regexp( {imagefiles.name}, '\d+', 'match', 'once' )));
    imagefiles = imagefiles(reindex);
    for ii=1:nfiles
       currentfilename = imagefiles(ii).name;
       currentimage = imread(append(versuchsbilderOrdnerName,folderFiles.name,'\',currentfilename));
       images{ii} = currentimage;
    end
    disp(append(" - ", num2str(nfiles), " Bilder wurden gefunden."));
catch
    disp("ERROR: Es ist ein Fehler beim lesen der Bilder aufgetreten");
    return;
end

%Matrizen erstellen für die ganzen detektieren höhen und speicher
%je Algo
detectedLineHeightMatrixHough = zeros([length(imagefiles),10]);
detectedLineHeightMatrixRedPlane = zeros([length(imagefiles),10]);
detectedLineHeightMatrixSaettigung = zeros([length(imagefiles),10]);
save('detectedLineHeightMatrixHough.mat','detectedLineHeightMatrixHough');
save('detectedLineHeightMatrixRedPlane.mat','detectedLineHeightMatrixRedPlane');
save('detectedLineHeightMatrixSaettigung.mat','detectedLineHeightMatrixSaettigung');

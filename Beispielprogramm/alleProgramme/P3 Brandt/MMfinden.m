% Gibt die Pixel in X und Y richtung aus die ein Millimeter im durchschnitt
% hat
%
% [X,Y]=MMfinden(E_Bild)  E_Bild=Eingangsbildmatrix
%                         [X,Y]=Pixel pro mm in X/Y
%

function [X,Y]=MMfinden(E_Bild)

E_Bild = double(E_Bild);
%n und m sobelfilter
Sob_N_F = [0.125000000000000,0,-0.125000000000000;
    0.250000000000000,0,-0.250000000000000;
    0.125000000000000,0,-0.125000000000000];
Sob_M_F = [0.125000000000000,0.250000000000000,0.125000000000000;
    0,0,0;
    -0.125000000000000,-0.250000000000000,-0.125000000000000];

%Entrauscht das bild erst und wendet dann die beiden Sobel an
GausEntrauscht_EBild = imgaussfilt(E_Bild);
Sobel_N = Faltung(GausEntrauscht_EBild,Sob_N_F);
Sobel_M = Faltung(GausEntrauscht_EBild,Sob_M_F); %Gibt figure 1 aus...


%Findet die gute linie die möglicht durch der mitte von eines Kästchen fürt
%btw die durch ganze bild sowenige wagerechte/bzw. senkrechte kanten erwischt 
%wenn das kästchen papier nicht ganz grade ist
GutelinieX = HoehenPixelFinden(E_Bild);
GutelinieY = BreitenPixelFinden(E_Bild);


%Linescans aus dem gausbild und den Sobeln/m bild um die nacher die kanten
%zu finden
GausLinieX = GausEntrauscht_EBild(GutelinieX,:);
SobelLinieX = Sobel_N(GutelinieX,:) ;
SobelLinieY = Sobel_M(:,GutelinieY)';
GausLinieY = GausEntrauscht_EBild(:,GutelinieY)';


%Berechnet die pixel pro mm für X und Y
[X,X_Kanten] = MMproPXfinden(SobelLinieX, GausLinieX);
[Y,Y_Kanten] = MMproPXfinden(SobelLinieY, GausLinieY);


%Gibt ein bild aus das dazu verwendet werden kann um zu vergleichen falls
%nicht sinfreihe werte bei der berechnung rauskommen wo die linien sind
PlotVergleichsbild(GausEntrauscht_EBild,GutelinieX,GutelinieY,X_Kanten,Y_Kanten);

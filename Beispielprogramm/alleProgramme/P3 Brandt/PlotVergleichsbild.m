%Warning: Marker input is ignored. Hier warum auch immer
%
% Plottet ein Vergleichs bild Mit dem Oridinalbild mit den X und Y
% Linescans und den Gefundenen Kanten um zu gucken wenn Das Programm daten Ausspuckt wo die Linescans
% sind und ob das Bild Optimal genug aufgenommen wurde
%
% PlotVergleichsbild(GausEntrauscht_EBild,GutelinieX,GutelinieY)
%                   GausEntrauscht_EBild
%                   GutelinieX = Der X-Pixel in dem die Beste Linie gefunden wurde
%                   GutelinieY = Der Y-Pixel in dem die Beste Linie gefunden wurde
%                   X_Kanten = Die gefundenen Kanten im X-Scan
%                   Y_Kanten = Die gefundenen Kanten im Y-Scan


function PlotVergleichsbild(GausEntrauscht_EBild,GutelinieX,GutelinieY,X_Kanten,Y_Kanten)


figure('Name','Vergleichsbild mit gefundenen Kanten'),subplot(3,1,1);
hold off;
imagesc(GausEntrauscht_EBild);colormap(gray);hold on;
yline(GutelinieX,'r','LineWidth',3);hold on;
xline(GutelinieY,'b','LineWidth',3);
hold off;
subplot(3,1,2),plot(GausEntrauscht_EBild(GutelinieX,:),'r');hold on;
plot(X_Kanten,'b'); 
hold off;
subplot(3,1,3),plot(GausEntrauscht_EBild(:,GutelinieY),'b');hold on;
plot(Y_Kanten,'r');
hold off;
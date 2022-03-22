%Gibt den Anteil der gefärbten gels in mm und in % des gesamtgels zurück
%
%I = Prak3(E_Bild)  I = 2D Vector mit den mm und den Prozanteil
%                   E_Bild = Eingangsbildmatrix


function I = Prak3(E_Bild)

close all


E_Bild = double(E_Bild); 
E_Bild = imgaussfilt(E_Bild);

%a()
[~,y] = MMfinden(E_Bild); %Mit deinem pixel pro MM funktion erstetzen

%b teil1()
Bereinigte_Kanten = Kantenbreinigen(E_Bild);
[~,laenge_BKanten] = size(Bereinigte_Kanten);
z=1;
for i=1:2:laenge_BKanten
    
    %b teil2()
    EinzeldesGlass = GlassAusschneiden(E_Bild,i,Bereinigte_Kanten); %Schneided ein einzelndes Glas aus
    temp = uint8(EinzeldesGlass);
    figure("Name","b() Ausgeschnittenes Bild"); imagesc(EinzeldesGlass); colormap(gray);

    %c()
    Gedreht = kuvDrehen(temp); %dreht glass
    figure("Name","c() Gedrehtes Ausgeschnittenes Bild"); imagesc(Gedreht); colormap(gray);
    
    %d()
    [ErsteLinie,MittlereLiniePX,UntereLinie]=OMU_KantenFinden(Gedreht); %Finded die 3 kanten
    
    %e()
    [MM,Proz] = KurvetteMM(ErsteLinie,MittlereLiniePX,UntereLinie,y); % Berechnet die mm und %
    MMuProz(z,1) = MM;
    MMuProz(z,2) = Proz;
    z=z+1;
end
I = MMuProz
Abw = ["Standartabweichung von mm",std(MMuProz(:,1))];
disp(Abw);
Abw = ["Standartabweichung von %",std(MMuProz(:,2))];
disp(Abw);

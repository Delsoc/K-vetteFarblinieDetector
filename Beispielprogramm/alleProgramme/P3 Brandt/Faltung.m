% Filterfaltung ueber ein Bild
%
% A_Bild=Faltung(E_Bild, Filter)  E_Bild=Eingangsbildmatrix
%                                 Filter=FaltungsFilter
%                                 A_Bild=Ausgangsbildmatrix
%

function A_Bild=Faltung(E_Bild, Filter)

% liefert die Groesse des Bildes/Filters
[hoehe,breite]=size(E_Bild);
[hoehe_Filter,breite_Filter]=size(Filter);

% Verwandelt diese in double zur rechnung
A_Bild = zeros([hoehe,breite]);
E_Bild = double(E_Bild);
A_Bild = double(A_Bild);
Filter = double(Filter);

%Ersten beiden For schleifen gehen durchs bild Pixel für pixel
%Wobei an den Randern mit round und floor Pixel ignoriert werden
%jenachdem wie groß der Filter ist
%Die inneren beiden Durch den Filter
for i=round(hoehe_Filter/2):hoehe-floor(hoehe_Filter/2)
    for j=round(breite_Filter/2):breite-floor(breite_Filter/2) 
        temp = 0; % Summe des Filterrechnung
        temp_I = -floor(hoehe_Filter/2); %Offset für das bild beim Filter um auf Pixel i-1 i-2 etc zuzugreifen
        for e=hoehe_Filter:-1:1
            temp_j = -floor(hoehe_Filter/2); % same as above
            for p=breite_Filter:-1:1
                % + wegen da bei temp_I schon - ist
                temp = temp + Filter(e,p)*E_Bild(i+temp_I,j+temp_j);
                temp_j = temp_j + 1;
            end
            temp_I = temp_I + 1;
        end
        A_Bild(i,j) = temp;        
    end
end

%Image anzeigen
%figure; imagesc(A_Bild); colormap(gray);
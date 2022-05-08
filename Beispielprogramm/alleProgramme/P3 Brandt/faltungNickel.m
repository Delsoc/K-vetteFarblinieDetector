% Nickel
% Faltung eines Bildes
%
% B=faltungNickel(A,h)
%               A=Eingangsbildmatrix
%               h=Faltungsoperator
%               B=gefaltete Bildmatrix
%


function B=faltungNickel(A,h)


[hoehe,breite]=size(A);
B=zeros(hoehe,breite);
A=double(A);


var=0;
for n=2:hoehe-1
    for m=2:breite-1
        for i=1:3
            for j=1:3
                var=var+h(i,j)*A(n+2-i,m+2-j);
            end
            
        end
        B(n,m)=var;
        var=0;
    end
end


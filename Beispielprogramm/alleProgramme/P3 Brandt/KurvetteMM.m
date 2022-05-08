%rechnet die größe des gefärbten teils in mm und Prozent des
%gesamtwasserstandes mithilfe des px/mm wertes aus Prak2 aus
%
% [MM,Proz] = KurvetteMM(ErsteLinie,MittlereLiniePX,UntereLinie,yxp)
%   MM = hohe des gefärbten wassers in mm
%   Proz = wieviel Prozent des wassers ist Gefärbt
%   ErsteLinie = Der Pixel von dem Eingansbild in dem die Wasslinie
%                  gefunden wurde
%   MittlereLinie = Der Pixel von dem Eingansbild in dem die Farblinie
%                     gefunden wurde
%   UntereLinie = Der Pixel von dem Eingansbild in dem die Glass
%                   gefunden wurde   
%   yxp = pixel pro 1mm in Y richtung

function [MM,Proz] = KurvetteMM(ErsteLinie,MittlereLiniePX,UntereLinie,yxp)
MM = (UntereLinie-MittlereLiniePX)/yxp;
Proz=((UntereLinie-MittlereLiniePX)*100)/(UntereLinie-ErsteLinie);
function [squareNotch] = SquareNotchFilter(startFlt,endFlt,fullLength,timeBw,notch)
% Dans cette m�thode on fait un array 2D dans lequel on place notre filtre
% temporellement pour permettre de seulement retirer la fr�quence
% ind�sirable sur une p�riode donn�e. Une partie du code est similaire �
% celui du script HanningNotch, nous ne reviendrons pas sur ce qui est
% redondant.

Z = zeros(fullLength,1);

% V�rifie si la largeur du bandwidth temporel est r�aliste. M�me principe
% que pour avant, sauf qu'on regarde pour les deux points dans le temps
% (d�but et fin).
if startFlt-timeBw < 1 || startFlt+timeBw > fullLength
    timeBw = min([startFlt-1 fullLength-startFlt]);
end
if endFlt-timeBw < 1 || endFlt+timeBw > fullLength
    
    timeBw = min([endFlt-1 fullLength-endFlt]);
end

%On fait une fonction porte qui va englober les deux Hanning
for i = startFlt-timeBw:endFlt+timeBw
    Z(i,1) = 1;
end

% On ajoute les deux Hanning dans le vecteur.
M = timeBw*2-1;

decal = startFlt - timeBw;
for n = startFlt-timeBw:startFlt+timeBw
    Z(n) = 0.5*(1-cos(2*pi*(n-decal)/M));
end

decal = endFlt - timeBw+1;
for n = endFlt-timeBw:endFlt+timeBw
    Z(n) = 0.5*(1-cos(2*pi*(n-decal)/M));
end

% On rempli entre les deux filtres pour obtenir le filtre temporel
% souhait�.
for i = startFlt:endFlt
    Z(i,1) = 1;
end

% On place la matrice dans la m�me orientation que pour le spectrogramme.
% On prend aussi le temps de l'inverser pour pouvoir la multiplier au
% spectrogramme de l'extrait audio. Maintenant on a un vrai bandstop
% filter.
ret = notch' * Z';
ret = (ret - 1)* -1;

squareNotch = ret;

end


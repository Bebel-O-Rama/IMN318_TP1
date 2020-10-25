function [squareNotch] = SquareNotchFilter(startFlt,endFlt,fullLength,timeBw,notch)
% Dans cette méthode on fait un array 2D dans lequel on place notre filtre
% temporellement pour permettre de seulement retirer la fréquence
% indésirable sur une période donnée. Une partie du code est similaire à
% celui du script HanningNotch, nous ne reviendrons pas sur ce qui est
% redondant.

Z = zeros(fullLength,1);

% Vérifie si la largeur du bandwidth temporel est réaliste. Même principe
% que pour avant, sauf qu'on regarde pour les deux points dans le temps
% (début et fin).
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
% souhaité.
for i = startFlt:endFlt
    Z(i,1) = 1;
end

% On place la matrice dans la même orientation que pour le spectrogramme.
% On prend aussi le temps de l'inverser pour pouvoir la multiplier au
% spectrogramme de l'extrait audio. Maintenant on a un vrai bandstop
% filter.
ret = notch' * Z';
ret = (ret - 1)* -1;

squareNotch = ret;

end


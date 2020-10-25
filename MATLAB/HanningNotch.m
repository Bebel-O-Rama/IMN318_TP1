function [notch] = HanningNotch(freqN,fsN,bandwidth)
% Initialize un vecteur de la longueur de la fr�quence d'�chantillonnage de
% l'extrait audio.
Z = zeros(1,fsN);

% V�rifie si la largeur du filtre est r�aliste. Une contrainte que nous
% avons accept� pour ce filtre est qu'il doit pouvoir �tre compl�tement
% int�gr� dans le signal. R�ajuste la taille du filtre si n�cessaire.
if freqN-bandwidth < 1 || freqN+bandwidth > fsN
    bandwidth = min([freqN-1 fsN-freqN]);
end

% Transforme le vecteur de 0 en fonction porte. On assigne 1 l� o� le
% filtre va affecter le signal
for i = freqN-bandwidth:freqN+bandwidth
    Z(1,i) = 1;
end

% Le M est en fonction de la largeur du filtre. 
M = bandwidth*2-1;
% Un d�calage pour le cos du filtre, question qu'il soit toujours centr�
% avec la fr�quence qu'on veut retirer.
decal = freqN - bandwidth;

% Boucle dans laquelle on change nos "1" dans notre vecteur pour y mettre
% un notch filter (bas� sur la formule de Hanning)
for n = freqN-bandwidth:freqN+bandwidth
    Z(n) = 0.5*(1-cos(2*pi*(n-decal)/M));
end

% On retourne le filtre 1D
notch = Z;
end


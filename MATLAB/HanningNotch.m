function [notch] = HanningNotch(freqN,fsN,bandwidth)
% Initialize un vecteur de la longueur de la fréquence d'échantillonnage de
% l'extrait audio.
Z = zeros(1,fsN);

% Vérifie si la largeur du filtre est réaliste. Une contrainte que nous
% avons accepté pour ce filtre est qu'il doit pouvoir être complètement
% intégré dans le signal. Réajuste la taille du filtre si nécessaire.
if freqN-bandwidth < 1 || freqN+bandwidth > fsN
    bandwidth = min([freqN-1 fsN-freqN]);
end

% Transforme le vecteur de 0 en fonction porte. On assigne 1 là où le
% filtre va affecter le signal
for i = freqN-bandwidth:freqN+bandwidth
    Z(1,i) = 1;
end

% Le M est en fonction de la largeur du filtre. 
M = bandwidth*2-1;
% Un décalage pour le cos du filtre, question qu'il soit toujours centré
% avec la fréquence qu'on veut retirer.
decal = freqN - bandwidth;

% Boucle dans laquelle on change nos "1" dans notre vecteur pour y mettre
% un notch filter (basé sur la formule de Hanning)
for n = freqN-bandwidth:freqN+bandwidth
    Z(n) = 0.5*(1-cos(2*pi*(n-decal)/M));
end

% On retourne le filtre 1D
notch = Z;
end


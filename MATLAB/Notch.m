function [Z] = Notch(freqToNotch,fsN,bandwidth,startFlt,endFlt,fullLength,timeBw,X)

% Méthode qui retourne un vecteur qui contient le notch filter (avec la
% méthode de Hamming)
notch = HanningNotch(freqToNotch,fsN,bandwidth);

% Méthode qui prend nos variables temporelles et notre vecteur de notch 
% filter pour en faire un filtre temporel en 2D.
squareNotch = SquareNotchFilter(startFlt,endFlt,fullLength,timeBw,notch);

% On applique le filtre sur le signal pour retirer la fréquence
% indésirable.
Z = X .* squareNotch;

end


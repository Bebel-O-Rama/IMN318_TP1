function [Z] = Notch(freqToNotch,fsN,bandwidth,startFlt,endFlt,fullLength,timeBw,X)

% M�thode qui retourne un vecteur qui contient le notch filter (avec la
% m�thode de Hamming)
notch = HanningNotch(freqToNotch,fsN,bandwidth);

% M�thode qui prend nos variables temporelles et notre vecteur de notch 
% filter pour en faire un filtre temporel en 2D.
squareNotch = SquareNotchFilter(startFlt,endFlt,fullLength,timeBw,notch);

% On applique le filtre sur le signal pour retirer la fr�quence
% ind�sirable.
Z = X .* squareNotch;

end


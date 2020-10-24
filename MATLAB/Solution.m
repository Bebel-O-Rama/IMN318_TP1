% Domaine de fr�quence et d'intensit� pour le spectrogramme final.
Fr = [0 8000];
clim = [-45 0];

% Calcul de notre signal, fr�quence d'�chantillonage, fen�tre d'Hamming et
% de la longueur de nos fen�tres pour le spectrogramme.
[x, fs] = audioread('Glock.wav');
N = 200*fs/1000;
win = hamming(N);
hop = round(length(win)/4);

% Calcul du spectrogramme.
X = STFT(x, win, hop);

% Formate le spectrogramme pour mieux pouvoir trouver les notes de
% l'extrait audio.
DispSTFT(X/max(abs(X(:))), fs, length(win), hop, Fr, clim);
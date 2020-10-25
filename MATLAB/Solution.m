%       Nicolas Auclair-Labbé, aucn2303
%       Félix Lussier

%
%       NUMÉRO 1, GLOCK.WAV       
%   

% Domaine de fréquence et d'intensité pour le spectrogramme final.
Fr = [0 15000];
clim = [-50 0];

% Calcul de notre signal, fréquence d'échantillonage, fenêtre d'Hamming et
% de la longueur de nos fenêtres pour le spectrogramme.
[x, fs] = audioread('Glock.wav');
N = 200*fs/1000;
win = hamming(N);
hop = round(length(win)/4);

% Calcul du spectrogramme.
X = STFT(x, win, hop);

% Formate le spectrogramme pour mieux pouvoir trouver les notes de
% l'extrait audio.
DispSTFT(X/max(abs(X(:))), fs, length(win), hop, Fr, clim);

%
%       NUMÉRO 2, RESTORE.WAV
%

% Domaine de fréquence et d'intensité pour le spectrogramme de base.
Fr = [0 16000];
clim = [-50 0];

% Calcul de notre signal, fréquence d'échantillonage, fenêtre d'Hamming et
% de la longueur de nos fenêtres pour le spectrogramme.
[x, fs] = audioread('Restore.wav');
N = 100*fs/1000;
win = hamming(N);
hop = round(length(win)/4);

% Calcul et image du spectrogramme non corrigé. À l'aide de ce
% spectrogramme nous avons pu déterminer que la fréquence à retirer se
% trouve autour de 516Hz et dure environ de 980à 2200ms.
X = STFT(x, win, hop);
DispSTFT(X/max(abs(X(:))), fs, length(win), hop, Fr, clim);

% Variable pour la création et l'application du notch filter selon une
% fréquence précise, une amplitude et des variables temporelles de début 
% et de fin.
freqHzNotch = 516;
bandwidth = 100;
startMs = 980;
endMs = 2200;
timeBwMs = 100;

fsN = size(X,1);
fullLength = size(X,2);

% On va convertir les bornes temporelles (qui sont présentement
% en millisecondes) pour obtenir leur valeur selon l'axe des x du
% spectrogramme. Même chose pour le bandwidth qui est présentement en ms.
% On fait aussi quelques vérifications pour être sur que tout est conforme.
timeBw = round(fs/hop*timeBwMs/1000);
if timeBw == 0
    timeBw = 2;
end

startFlt = round(fs/hop*startMs/1000);
endFlt = round(fs/hop*endMs/1000);
if min([startFlt > endFlt])
    temp - endFlt;
    endFilt = startFlt;
    startFlt = temp;
end

% On va aussi convertir la fréquence en unité du spectrogramme, donc de Hz
% à un ratio qui tient compte de la fenêtre utilisé pour faire le
% spectrogramme.
freqToNotch = round(freqHzNotch*(fsN/fs));

% notch = HanningNotch(freqHzNotch,fsN,bandwidth,gain);
% squareNotch = SquareNotchFilter(startMs,endMs,fullLength,notch);
% Méthode qui applique un filtre type "notch" sur notre spectrogramme.
X = Notch(freqToNotch,fsN,bandwidth,startFlt,endFlt,fullLength,timeBw,X);


%%%%%%%%%%%%%% ICI ON DOIT PLUGGER LA TF INVERSE DE X. APRÈS IL FAUT LE
%%%%%%%%%%%%%% PRINTER ET SORTIR LA TRACK AUDIO

% Formate le spectrogramme pour mieux pouvoir trouver les notes de
% l'extrait audio.
%DispSTFT(X/max(abs(X(:))), fs, length(win), hop, Fr, clim);

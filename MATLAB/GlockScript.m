[x, fs] = audioread('Glock.wav');

[H, W] = freqz(x);

Fr = [0 8000];
clim = [-50 0];
N = 400*fs/1000;
win = hamming(N);
hop = round(length(win)/4);

X = STFT(x, win, hop);

%imagesc(log(abs(X)));

DispSTFT(X/max(abs(X(:))), fs, length(win), hop, Fr, clim);




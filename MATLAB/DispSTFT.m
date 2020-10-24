function [] = DispSTFT(X,fs, lengthWin, hop, Fr, clim)

xTickSecond = fs/hop; 

X = abs(X);                        % On retire la composante imaginaire (elle n'est pas utile pour déterminer l'amplitude en dB)
shift = round(lengthWin/2);

Y = X(1:shift,:);                  % Maintenant on a retiré la 2e moitié du spectrograme (symétrie d'amplitude)
[x,y] = size(Y);   
               
maxRow = max(Y,[],'omitnan');
maxAmp = max(maxRow);
maxAmp                             % Vérification qui permet de s'assurer qu'il n'y a pas d'amplitude suppérieur à 1 avant de les convertir en dB 

Y = 20*log10(Y);    % On a maintenant les valeurs d'intensité en dB ET on multiplie par 2 pour compenser la symétrie d'amplitude

for i = 1 : x
    for j = 1 : y
        if Y(i,j)< min(clim) || Y(i,j)>max(clim)   % On n'est pas obligé de regarder si l'amplitude est suppérieur à 0, comme ce serait impossible (on a déjà restraint nos résultats entre 0 et 1)
            Y(i,j) = -100;                         % On plug les points où l'intensité est inférieur à -50dB
        end
    end
end

imagesc(Y)                                     % On print l'image avec du jus de formatage
ax = gca
ax.YDir = 'normal';
ax.Title.String = 'Glock.wav';
ax.XLabel.String = 'Time (in seconds)';
ax.XTick = 0:xTickSecond:y;                    % Place un tick par seconde     
ax.XTickLabel = 0:1:99;                        % Une limite (le 99) un peu bidon, on veut seulement que le label soit toujours en seconde
ax.YLabel.String = 'Frequency (in Hz)';
%set(gca,'Ydir','normal')
end


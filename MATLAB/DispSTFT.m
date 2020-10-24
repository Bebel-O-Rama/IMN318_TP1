function [] = DispSTFT(X,fs, lengthWin, hop, Fr, clim)

xTickSecond = fs/hop; 

X = abs(X);                        % On retire la composante imaginaire (elle n'est pas utile pour d�terminer l'amplitude en dB)
shift = round(lengthWin/2);

Y = X(1:shift,:);                  % Maintenant on a retir� la 2e moiti� du spectrograme (sym�trie d'amplitude)
[x,y] = size(Y);   
               
maxRow = max(Y,[],'omitnan');
maxAmp = max(maxRow);
maxAmp                             % V�rification qui permet de s'assurer qu'il n'y a pas d'amplitude supp�rieur � 1 avant de les convertir en dB 

Y = 20*log10(Y);    % On a maintenant les valeurs d'intensit� en dB ET on multiplie par 2 pour compenser la sym�trie d'amplitude

for i = 1 : x
    for j = 1 : y
        if Y(i,j)< min(clim) || Y(i,j)>max(clim)   % On n'est pas oblig� de regarder si l'amplitude est supp�rieur � 0, comme ce serait impossible (on a d�j� restraint nos r�sultats entre 0 et 1)
            Y(i,j) = -100;                         % On plug les points o� l'intensit� est inf�rieur � -50dB
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


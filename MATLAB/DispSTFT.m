function [] = DispSTFT(X,fs, lengthWin, hop, Fr, clim)

% On retire la 2e moiti� du spectrograme (sym�trie d'amplitude).
[x,y] = size(X); 
shift = round(x/2);
Y = X(1:shift,:);               

% V�rification pour s'assurer que la fr�quence minimal demand� n'est pas
% inf�rieur � 1. Si oui on ajuste pour ne pas essayer d'acc�der � un index
% 0 dans un array.
[m,i] = min(Fr)
if m < 1                           
    Fr(i) = 1;
end

    
% On fait une derni�re r�duction du spectrograme selon l'amplitude
% fr�quentielle souhait�.
%Y = Y(min(Fr):max(Fr),:);        

[x,y] = size(Y);   
Y = abs(Y);

% Petite v�rification qu'il n'y a pas d'intensit� sonore supp�rieure � 1 ou
% inf�rieur � 0 avant de les convertir en dB avec l'intensit� la plus forte 
% comme r�f�rence. 
maxRow = max(Y,[],'omitnan');
maxAmp = max(maxRow);
minRow = min(Y,[],'omitnan');
minAmp = min(maxRow);

if maxAmp > 1 || minAmp < 0
    Y = Y/max(abs(Y(:)));
end

%Conversion de l'intensit� en dB avec le son le plus fort comme r�f�rence
%(0)

Y = 20*log10(Y);  

% Pour chaque point on regarde si l'intensit� est en dehors de notre
% ambitus souhait�. Si oui on met le point � -100dB.
for i = 1 : x
    for j = 1 : y
        if Y(i,j)< min(clim) || Y(i,j)>max(clim) 
            Y(i,j) = -100;                         
        end
    end
end

% Affichage de l'image avec quelques modifications plus bas pour le 
% formatage. On fait la conversion pour montrer le temps en seconde et les
% fr�quences en Hz.
xTickSecond = fs/hop; 
yTickHz = fs/lengthWin;
Fr = Fr/yTickHz;

imagesc(Y)                                     
ax = gca
ax.YDir = 'normal';
ax.Title.String = 'Glock.wav';
ax.XLabel.String = 'Time (in seconds)';
ax.XTick = 0:xTickSecond:y;                    
ax.XTickLabel = 0:1:99;                        
ax.YLabel.String = 'Frequency (in Hz)';
ax.YTick = 0:yTickHz:x;
ax.YTickLabel = 0:yTickHz^2:100000;    
ax.YLim = [min(Fr) max(Fr)]

end


function [] = DispSTFT(X,fs, lengthWin, hop, Fr, clim)

% On retire la 2e moitié du spectrograme (symétrie d'amplitude).
[x,y] = size(X); 
shift = round(x/2);
Y = X(1:shift,:);               

% Vérification pour s'assurer que la fréquence minimal demandé n'est pas
% inférieur à 1. Si oui on ajuste pour ne pas essayer d'accéder à un index
% 0 dans un array.
% On vérifie aussi que la fréquence maximal n'est pas au-delà de ce qui est
% possible, au besoin on se base sur la fréquence maximale du
% spectrogramme.
[m,i] = min(Fr)
if m < 1                           
    Fr(i) = 1;
end
[m,i] = max(Fr)
if m > shift
    Fr(i) = shift;
end
    
% On fait une dernière réduction du spectrograme selon l'amplitude
% fréquentielle souhaité.
%Y = Y(min(Fr):max(Fr),:);        

[x,y] = size(Y);   
Y = abs(Y);

% Petite vérification qu'il n'y a pas d'intensité sonore suppérieure à 1 ou
% inférieur à 0 avant de les convertir en dB avec l'intensité la plus forte 
% comme référence. 
maxRow = max(Y,[],'omitnan');
maxAmp = max(maxRow);
minRow = min(Y,[],'omitnan');
minAmp = min(maxRow);

if maxAmp > 1 || minAmp < 0
    Y = Y/max(abs(Y(:)));
end

%Conversion de l'intensité en dB avec le son le plus fort comme référence
%(0)

Y = 20*log10(Y);  

% Pour chaque point on regarde si l'intensité est en dehors de notre
% ambitus souhaité. Si oui on met le point à -100dB.
for i = 1 : x
    for j = 1 : y
        if Y(i,j)< min(clim) || Y(i,j)>max(clim) 
            Y(i,j) = -100;                         
        end
    end
end

% Affichage de l'image avec quelques modifications plus bas pour le 
% formatage (dont l'affichage du temps en secondes).
xTickSecond = fs/hop; 

imagesc(Y)                                     
ax = gca
ax.YDir = 'normal';
ax.Title.String = 'Glock.wav';
ax.XLabel.String = 'Time (in seconds)';
ax.XTick = 0:xTickSecond:y;                    
ax.XTickLabel = 0:1:99;                        
ax.YLabel.String = 'Frequency (in Hz)';
ax.YLim = [min(Fr) max(Fr)]

end


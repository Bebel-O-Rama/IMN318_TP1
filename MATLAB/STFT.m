function [X] = STFT(x,win, hop)
    
    % Trouve le nombre de tranche n�cessaire pour faire un spectrogramme
    % complet.
    limit = round((length(x)-length(win))/hop)-1;
    
    % Calcul du spectrogramme � l'aide de petites tranches de TF qui sont
    % coll�es avec un d�calage temporel.
    for i = 0:limit
        F = fft(x(i*hop + (1:length(win))) .* win, 44100);
        X(:,i+1) = F;
    end
end

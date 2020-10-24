function [X] = STFT(x,win, hop)
    
    % Trouve le nombre de tranche nécessaire pour faire un spectrogramme
    % complet.
    limit = round((length(x)-length(win))/hop)-1;
    
    % Calcul du spectrogramme à l'aide de petites tranches de TF qui sont
    % collées avec un décalage temporel.
    for i = 0:limit
        F = fft(x(i*hop + (1:length(win))) .* win, 44100);
        X(:,i+1) = F;
    end
end

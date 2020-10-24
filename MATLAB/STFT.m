function [X] = STFT(x,win, hop)

    limit = round((length(x)-length(win))/hop)-1;

    for i = 0:3
        F = fft(x(i*hop + (1:length(win))) .* win);
        X(:,i+1) = F;
        figure
        imagesc(abs(X))
    end
end

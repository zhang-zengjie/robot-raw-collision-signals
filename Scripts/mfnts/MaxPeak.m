function [Fdm,Pks,Agl] = MaxPeak(f,AP,AG)
% This function returns the max peak and the corresponding foundamental
% frequency 

    [P,I] = findpeaks(AP);
    if (isempty(P) || isempty(I))
        Pks = 0;
        Fdm = 0;
        Agl = 0;
    else
        [Pks,Maxi] = max(P);
        Fdm = f(I(Maxi));
        Agl = AG(I(Maxi));
    end

end


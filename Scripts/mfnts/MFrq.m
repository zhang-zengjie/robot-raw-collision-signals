function [Fdm,Pks,Agl] = MFrq(f,AP,AG, sz)
% This function returns the max peak and the corresponding foundamental
% frequency 

    Fdm = sum(f.*AP)/sum(AP);
    IF = ceil((Fdm-f(1))*sz/(f(end)-f(1)));
    if (IF == 0) || (isnan(IF))
        IF = 1;
    end
    Pks = AP(IF);
    Agl = AG(IF);

end


% PwrRt calculates the power ratio of a sequence
%   PR = PwrRt(AP, fw, fc) returns a real number PR as a result of logged
%   ratio;
%   'AP' is the input sequence (time sequence or frequency spectrum), which 
%   increase vertically down; each row denotes parallel sequences;
%   'ss' is the starting index of the sequence;
%   'sc' is the central index of the sequence;
%   'se' is the ending index of the sequence.

function PR = PwrRt(AP, ss, sc, se)
    num = sum(AP(sc+1:se).^2);
    den = sum(AP(ss+1:sc).^2);
    if ((num < 1e-20) || (den < 1e-20))
        PR = 0;
    else
        PR = log(num/den);
    end
end


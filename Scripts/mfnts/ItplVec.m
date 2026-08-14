function [VecOut] = ItplVec(VecIn)
%ITPLVEC Summary of this function goes here
%   Detailed explanation goes here
N = max(size(VecIn));
VecOut =floor((VecIn(1:N-1)+VecIn(2:N))/2);

end


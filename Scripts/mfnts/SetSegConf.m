% SetSegConf initialize the segmentation configuration
%   SegConf = SetSegConf(sRowSlc, sWinSz, sWinBias, sWinChop, sWinStyl);
%   
%   Parameter(s):
%   1. 'sRowSlc' selects the joints of the signal;
%   2. 'sWinSz' determines the window size;
%   3. 'sWinBias' is the window bias from window start to collision start;
%   4. 'sWinStyl' chooses the window style to filter the segment;
%   5. 'sWinChop' chops the window according to starting and ending points.


function SegConf = SetSegConf(sSlcMtr, sWinSz, sWinBias, sWinStyl, sWinChop)

SegConf.SlcMtr = sSlcMtr;
SegConf.WinSz = sWinSz;
SegConf.WinBias = sWinBias;
SegConf.WinChop = sWinChop;

Nwin = ceil(SegConf.WinSz/(SegConf.WinChop(2)-SegConf.WinChop(1)));
SegConf.WinStyl = sWinStyl(Nwin);
SegConf.WinCoef = SegConf.WinStyl(fix(Nwin*0.4)+1:fix(Nwin*0.4)+SegConf.WinSz);

end
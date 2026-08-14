RtPath = ['/home/jerry/Workspace/J12rcml','/DBshare/mat/'];
addpath('mfnts');

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% If you use CNN based on short fourier transformation
% 
% [ClsFtrs, CtcFtrs, FreFtrs, ClsTims, CtcTims, FreTims] = GenFtr(GenList(RtPath), ...
%                             SetSegConf([1 1 1 1 1 1 1]', 512, 20, @rectwin, [0.4, 1]), ...
%                             SetFtrConf("cnn-stft", 256, 20, @hanning, 15, "Amplog"), ...
%                             SetFltConf("nofilter", 100), ...
%                             RtPath, "2D");
%                             % Hyper-parameter lists:
%                             % 1. Mode;
%                             % 2. STFT frequency points;
%                             % 3. STFT window size;
%                             % 4. STFT window;
%                             % 5. STFT overlapping between windows;
%                             % 6. Output type;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%                        
                        
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%       
% If you use CNN based on wavelet transformation
%
[ClsFtrs, CtcFtrs, FreFtrs, ClsTims, CtcTims, FreTims] = GenFtr(GenList(RtPath), ...
                            SetSegConf([1 1 1 1 1 1 1]', 129, 20, @rectwin, [0.4, 1]), ...
                            SetFtrConf("cnn-wlt", 128, 'cmor4-4', "Amplog"), ...
                            SetFltConf("nofilter", 100), ...
                            RtPath, "2D");
                            % Hyper-parameter lists:
                            % 1. Mode;
                            % 2. WLT frequency points;
                            % 3. Wavelet name;
                            % 4. Output type;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%%
SzCls = size(ClsFtrs);
SzCtc = size(CtcFtrs);
SzFre = size(FreFtrs);

D = [[ones(SzCls(1),1), ClsFtrs];
    [-ones(SzCtc(1),1), CtcFtrs]; 
    [zeros(SzFre(1),1), FreFtrs]];

csvwrite('cnn-cwt-dataset.csv', D);
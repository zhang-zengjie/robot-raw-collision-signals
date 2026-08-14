% function D = gen_dt(RtPath, FcPath, Width, Bias)

Width = 300;
Bias = 0;
RtPath = '.';
FcPath = 'Scripts/mfnts';

addpath(FcPath)
% Hyper-parameter list for segmentation:
% 1. Joint selection;
% 2. Segmentation window size;
% 3. Window bias;
% 4. Window style;
% 5. Window chopping marks.


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% If you extract features
%    

%IFeature = [2, 12, 9, 4, 15, 1, 5, 3, 18, 6, 17, 14, 7, 16, 10, 11, 13, 8];
IFeature = 1:18;
% [1 1 1 1 1 1 1]'
%IFeature = [1, 3, 4, 6, 8, 9, 10, 11, 12, 14, 15, 16, 17, 18];


[ClsFtrs, CtcFtrs, FreFtrs, ClsTims, CtcTims, FreTims] = GenFtr(GenList(RtPath), ...
                            SetSegConf(eye(7), Width, Bias, @rectwin, [0.4, 1]), ...
                            SetFtrConf("feature", IFeature, ...
                                0, 5, 500, 10, 20, 0.5), ...
                            SetFltConf("nofilter", 100), ...
                            RtPath, "2D");

                            % Hyper-parameter lists:
                            % 1. Mode;
                            % 2. Feature selection;
                            % 3. FFT frequency point numbers;
                            % 4. Lower power ratio center;
                            % 5. Higher power ratio center;
                            % 6. Time domain increase part in percentage;
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%                  
% Feature List:
% 1. FtrMean: mean value of the seg
% 2. FtrVar: variance of the seg
% 3. FtrMed: median of the seg
% 4. FtrRange: extreme range of the seg
% 5. FtrDev: extreme deviation of the seg
% 6. FtrKur: kurtosis of the seg
% 7. FtrSkw: skewness of the seg
% 8. FtrFdmFrq: Foundamental frequency
% 9. FtrFdmSpc: Spectrum amplitude of FdmFrq
% 10. FtrFdmAgl: Spectrum angle of FdmFrq
% 11. FtrMFrq: Mean frequency
% 12. FtrMSpc: Amplitude of mean frequency
% 13. FtrMAgl: Phase angle of mean frequency
% 14. FtrP2R: Crest factor
% 15. FtrAvrEgy: Signal average energy
% 16. PwrRt15: Energy ratio of lower subband
% 17. PwrRt40: Energy ratio of higher subband
% 18. PwrIcs: Energy increasing rate (time domain) by last 20%
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Feature Ranking
% 1. FtrVar;        (2)
% 2. FtrMSpc;       (12)
% 3. FtrFdmSpc;     (9)
% 4. FtrRange;      (4)
% 5. FtrAvrEgy;     (15)    
% 6. FtrMean;       (1)
% 7. FtrDev;        (5)
% 8. FtrMed;        (3)     
% 9. PwrIcs;        (18)
% 10. FtrKur;       (6)
% 11. PwrRt40;`     (17)
% 12. FtrP2R;       (14)
% 13. FtrSkw;       (7)
% 14. PwrRt15;      (16)
% 15. FtrFdmAgl;    (10)
% 16. FtrMFrq;      (11)
% 17. FtrMAgl;      (13)    
% 18. FtrFdmFrq;    (8)
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% [ClsFtrs, CtcFtrs, FreFtrs, ClsTims, CtcTims, FreTims] = GenFtr(GenList(RtPath), ...
%                             SetSegConf([1 1 1 1 1 1 1]', 512, 20, @rectwin, [0.4, 1]), ...
%                             SetFtrConf("rnn"), ...
%                             SetFltConf("nofilter", 100), ...
%                             RtPath, "2D");

SzCls = size(ClsFtrs);
SzCtc = size(CtcFtrs);
SzFre = size(FreFtrs);

D = [[ones(SzCls(1),1), ClsFtrs];
    [-ones(SzCtc(1),1), CtcFtrs]; 
    [zeros(SzFre(1),1), FreFtrs]];

% csvwrite('bias0.csv', D);
writematrix(D, 'full_set.csv', 'Delimiter', ',');
        
        
        
        

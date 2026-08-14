%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Script name: example
% Author: Zengjie Zhang
% Date: 2018.11.18
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This script is used to prepare the feature tensors ClsFtrs, CtcFtrs and
% FreFtrs.

RtPath = ['/home/jerry/Workspace/J12rcml','/DBshare/mat/'];
addpath('mfnts');
% Hyper-parameter list for segmentation:
% 1. Joint selection;
% 2. Segmentation window size;
% 3. Window bias;
% 4. Window style;
% 5. Window chopping marks.


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% If you extract features
%         
% [ClsFtrs, CtcFtrs, FreFtrs, ClsTims, CtcTims, FreTims] = GenFtr(GenList(RtPath), ...
%                             SetSegConf(eye(7)', 200, 490, @rectwin, [0.4, 1]), ... 
%                             SetFtrConf("feature", [2, 12, 9, 4, 1, 5, 18, 6, 17, 14, 7, 16, 10, 11, 8], ...
%                                 0, 5, 500, 15, 40, 0.82), ...
%                             SetFltConf("nofilter", 100), ...
%                             RtPath, "2D");
%                             % Hyper-parameter lists:
%                             % 1. Mode;
%                             % 2. Feature selection;
%                             % 3. FFT frequency point numbers;
%                             % 4. Lower power ratio center;
%                             % 5. Higher power ratio center;
%                             % 6. Time domain increase part in percentage;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% If you use RNN
% 
[ClsFtrs, CtcFtrs, FreFtrs, ClsTims, CtcTims, FreTims] = GenFtr(GenList(RtPath), ...
                            SetSegConf(eye(7)', 512, 20, @rectwin, [0.4, 1]), ...
                            SetFtrConf("rnn"), ...
                            SetFltConf("nofilter", 100), ...
                            RtPath, "3D");
                            % No hyper-parameters for rnn
%                          
%                         
%                         
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% If you use CNN based on short fourier transformation
% 
% [ClsFtrs, CtcFtrs, FreFtrs, ClsTims, CtcTims, FreTims] = GenFtr(GenList(RtPath), ...
%                             SetSegConf([0 0 0 0 1 0 0]', 129, 20, @rectwin, [0.4, 1]), ...
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
% [ClsFtrs, CtcFtrs, FreFtrs, ClsTims, CtcTims, FreTims] = GenFtr(GenList(RtPath), ...
%                             SetSegConf([0 0 0 0 1 0 0]', 129, 20, @rectwin, [0.4, 1]), ...
%                             SetFtrConf("cnn-wlt", 128, 'cmor4-4', "Amplog"), ...
%                             SetFltConf("nofilter", 100), ...
%                             RtPath, "2D");
%                             % Hyper-parameter lists:
%                             % 1. Mode;
%                             % 2. WLT frequency points;
%                             % 3. Wavelet name;
%                             % 4. Output type;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%       




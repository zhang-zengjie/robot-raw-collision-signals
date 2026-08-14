% Seg2Ftr transfer MAT-file data to feature vectors
%   Author: Jerry (Zengjie) Zhang
%   Date: 2018.11.23
%
% Function prototype:
%   Ftrs = Sgn2Ftr(DataSgn, Marks, SegConf, FtrConf, Dim, Mode)
%
% Parameter(s):
%   1. 'DataSgn' is the original data segment without time labels; (must) joint
%   axis as horizontal and time axis as vertical down;
%   2. 'Marks' is the vector of time instances when collisions or contacts 
%   occur;
%   3. 'SegConf' is the structure to store data segmentation hyper-parameters;
%   4. 'FtrConf' is the structure to store feature extraction hyper-parameters;
%   5. 'Dim' is the array of 1st-dimension and 3rd-dimension of the feature
%   tensors;
%   6. 'Mode' denote the way that features are extracted; Tolerate modes are:
%       "feature": which extracts features for norminal classifiers;
%       "rnn": which extracts sequence segments for rnns;
%       "cnn-stft": which extracts short-time fourier transformation features 
%                for cnns;
%       "cnn-wlt": which extracts wavelet transformation features for cnns;
%
% Returned value(s):
%   'Ftrs' is the 3-dimensional feature tensor corresponding to 2 MAT-file.


function [Ftrs, Tims] = Sgn2Ftr(DataSgn, Marks, NMark, SegConf, FtrConf, Dim)

Ftrs = zeros(Dim(1), NMark, Dim(2));
Tims = zeros(NMark,1);

switch FtrConf.Mode

case "feature"
    
    if (FtrConf.NFFT == 0)
        NFFT = SegConf.WinSz;
    else
        NFFT = FtrConf.NFFT;
    end
    fsc = FtrConf.Fs/NFFT;
    FDataSegf = fsc*(0:(NFFT/2))';
    
    Ii = ceil(FtrConf.Fi*NFFT/FtrConf.Fs)+1;
    Ie = ceil(FtrConf.Fe*NFFT/FtrConf.Fs)+1;
    
    FtrPwrIcs = zeros(1, Dim(1));
    FtrFdmFrq = zeros(1, Dim(1));
    FtrFdmSpc = zeros(1, Dim(1));
    FtrFdmAgl = zeros(1, Dim(1));
    FtrMFrq = zeros(1, Dim(1));
    FtrMSpc = zeros(1, Dim(1));
    FtrMAgl = zeros(1, Dim(1));
    FtrP2R = zeros(1, Dim(1));
    FtrAvrEgy = zeros(1, Dim(1));
    FtrPwrRtL = zeros(1, Dim(1));
    FtrPwrRtH = zeros(1, Dim(1));
    
    for i=1:NMark
        tic
        % Prepare time-domain signals
        DataSeg = DataSgn((Marks(i)-SegConf.WinBias+1):(Marks(i)-SegConf.WinBias+SegConf.WinSz),:).*SegConf.WinCoef;
        AbDataSeg = abs(DataSeg);
        % I. Generate time domain features
        FtrMean = mean(DataSeg);                                % 1. FtrMean: mean value of the seg
        FtrVar = var(DataSeg);                                  % 2. FtrVar: variance of the seg
        FtrSkw = skewness(DataSeg);                             % 3. FtrSkw: skewness of the seg
        FtrKur = kurtosis(DataSeg);                             % 4. FtrKur: kurtosis of the seg
        FtrMed = median(DataSeg);                               % 5. FtrMed: median of the seg
        FtrRange = max(AbDataSeg) - min(AbDataSeg);             % 6. FtrRange: extreme range of the seg
        FtrDev = max(AbDataSeg) - FtrMean;                      % 7. FtrDev: extreme deviation of the seg
        
       
        % Prepare frequency-domain spectrums

        FFT = fft(DataSeg, NFFT)/SegConf.WinSz;
        FFTAP = abs(FFT);
        FFTAG = angle(FFT);
        FDataSegAP = [FFTAP(1,:); 2*FFTAP(2:NFFT/2,:); FFTAP(NFFT/2+1,:)];
        FDataSegAG = FFTAG(1:NFFT/2+1,:);
        
        % II. Generate frequency domain features
        
        for j=1:Dim(1)
            FtrPwrIcs(j) = PwrRt(DataSeg(:, j), 0, ceil((1-FtrConf.PwrIcsPer)*SegConf.WinSz), SegConf.WinSz); 
                                                                    % 8. PwrIcs: Energy increasing rate (time domain) by last 20%

            [FtrFdmFrq(j), FtrFdmSpc(j), FtrFdmAgl(j)] = MaxPeak(FDataSegf(Ii:Ie), FDataSegAP(Ii:Ie, j), FDataSegAG(Ii:Ie, j));                  
                                                                    % 1. FtrFdmFrq: Foundamental frequency
                                                                    % 2. FtrFdmSpc: Spectrum amplitude of FdmFrq
                                                                    % 3. FtrFdmAgl: Spectrum angle of FdmFrq
            [FtrMFrq(j), FtrMSpc(j), FtrMAgl(j)] = MFrq(FDataSegf(Ii:Ie), FDataSegAP(Ii:Ie, j), FDataSegAG(Ii:Ie, j), NFFT/2+1);                                                        
                                                                    % 4. FtrMFrq: Mean frequency
                                                                    % 5. FtrMSpc: Amplitude of mean frequency
                                                                    % 6. FtrMAgl: Phase angle of mean frequency

            FtrP2R(j) = peak2rms(FDataSegAP(Ii:end, j));                % 7. FtrP2R: Crest factor
            % III. Energy Features
            FtrAvrEgy(j) = rms(FDataSegAP(Ii:end, j));                  % 8. FtrAvrEgy: Signal average energy
            FtrPwrRtL(j) = PwrRt(FDataSegAP(:, j), Ii, ceil(FtrConf.PwrRtL*(NFFT+2)/FtrConf.Fs), Ie);           % 9. PwrRt10: Energy ratio of lower subband
            FtrPwrRtH(j) = PwrRt(FDataSegAP(:, j), Ii, ceil(FtrConf.PwrRtH*(NFFT+2)/FtrConf.Fs), Ie);           % 10. PwrRt20: Energy ratio of higher subband

            FtrAll = [FtrMean(j), FtrVar(j), FtrSkw(j), FtrKur(j), FtrMed(j), FtrRange(j), FtrDev(j), FtrPwrIcs(j), FtrFdmFrq(j), FtrFdmSpc(j), FtrFdmAgl(j), FtrMFrq(j), FtrMSpc(j), FtrMAgl(j), FtrP2R(j), FtrAvrEgy(j), FtrPwrRtL(j), FtrPwrRtH(j)];
            Ftrs(j, i, :) = reshape(FtrAll(FtrConf.FtrSlc), [1,1,Dim(2)]);
        end
        Tims(i)=toc;
    end

case "rnn"

    for i=1:NMark
        tic
        for j=1:Dim(1)
            Ftrs(j, i, :) = reshape(DataSgn((Marks(i)-SegConf.WinBias+1):(Marks(i)-SegConf.WinBias+SegConf.WinSz),j).*SegConf.WinCoef, [1,1,Dim(2)]);
        end
        Tims(i)=toc;
    end

case "cnn-stft"

    for i=1:NMark
        tic
        for j=1:Dim(1)
            [S,~,~,P] = spectrogram(abs(DataSgn((Marks(i)-SegConf.WinBias+1):(Marks(i)-SegConf.WinBias+SegConf.WinSz),j)).*SegConf.WinCoef, FtrConf.SegWin, FtrConf.Ovl, FtrConf.NSTFT, FtrConf.Fs);
            switch FtrConf.Out
                case "Amp"
                    Ftrs(j, i, :) = reshape(abs(S), [1,1,Dim(2)]);
                case "Pwr"
                    Ftrs(j, i, :) = reshape(P, [1,1,Dim(2)]);
                case "Amplog"
                    Ftrs(j, i, :) = reshape(log(abs(S)), [1,1,Dim(2)]);
                case "Pwrlog"
                    Ftrs(j, i, :) = reshape(log(P), [1,1,Dim(2)]);
                otherwise
            end
        end
        Tims(i)=toc;
    end

case "cnn-wlt"
    
    scals=2*centfrq(FtrConf.wl)*FtrConf.NWLT./(1:FtrConf.NWLT);   
    for i=1:NMark
        tic
        for j=1:Dim(1)
            S = cwt(DataSgn((Marks(i)-SegConf.WinBias+1):(Marks(i)-SegConf.WinBias+SegConf.WinSz),j).*SegConf.WinCoef, scals, FtrConf.wl);
            switch FtrConf.Out
                case "Amp"
                    Ftrs(j, i, :) = reshape(abs(S), [1,1,Dim(2)]);
                case "Pwr"
                    P = abs(S).^2;
                    Ftrs(j, i, :) = reshape(P, [1,1,Dim(2)]);
                case "Amplog"
                    Ftrs(j, i, :) = reshape(log(abs(S)), [1,1,Dim(2)]);
                case "Pwrlog"
                    Ftrs(j, i, :) = reshape(2*log(abs(S)), [1,1,Dim(2)]);
                otherwise
            end
        end
        Tims(i)=toc;
    end

    otherwise
end










function FtrConf = SetFtrConf(Mode, varargin)

    try
        switch Mode
        case "feature"
            FtrConf.FtrSlc = varargin{1};
            FtrConf.NFFT = varargin{2};
            FtrConf.Fs = 1000;
            FtrConf.Fi = varargin{3};
            FtrConf.Fe = varargin{4};
            FtrConf.PwrRtL = varargin{5};
            FtrConf.PwrRtH = varargin{6};
            FtrConf.PwrIcsPer = varargin{7};
            FtrConf.Mode = Mode;
            FtrConf.flag = 1;
        case "rnn"
            FtrConf.Mode = Mode;
            FtrConf.flag = 1;
        case "cnn-stft"
            FtrConf.NSTFT = varargin{1};
            FtrConf.Fs = 1000;
            FtrConf.SegSz = varargin{2};
            FtrConf.SegWin = varargin{3}(FtrConf.SegSz);
            FtrConf.Ovl = varargin{4};
            FtrConf.Out = varargin{5};
            FtrConf.Mode = Mode;
            if ~ismember(FtrConf.Out, ["Amp","Pwr","Amplog","Pwrlog"])
                FtrConf.Out = "Amplog";
                disp(['Error: Undefined mode "', char(FtrConf.Out), '"! Default setting "Amplog" will be used ...']);
            end
            FtrConf.flag = 1;
        case "cnn-wlt"
            FtrConf.NWLT = varargin{1};
            FtrConf.Fs = 1000;
            FtrConf.wl = varargin{2};
            FtrConf.Out = varargin{3};
            FtrConf.Mode = Mode;
            if ~ismember(FtrConf.Out, ["Amp","Pwr","Amplog","Pwrlog"])
                FtrConf.Out = "Amplog";
                disp(['Error: Undefined mode "', char(FtrConf.Out), '"! Default setting "Amplog" will be used ...']);
            end
            FtrConf.flag = 1;
        otherwise
            disp(['Error: Undefined mode "', char(mode), '"!']);
            FtrConf.flag = 0;
            return
        end
    catch
        disp(['Param setting does not match mode ', char(Mode), ' ... Aborted.']);
        FtrConf.flag = 0;
    end
end


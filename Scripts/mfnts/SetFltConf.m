function FltConf = SetFltConf(Type, varargin)

FltConf.Fs = 1000;

switch Type
    case "bandpass"
        [FltConf.b, FltConf.a] = cheby1(2,1,[varargin{1}*2/FltConf.Fs varargin{2}*2/FltConf.Fs],'bandpass');
         FltConf.flag = 1;
    case "lowpass"
        [FltConf.b, FltConf.a] = cheby1(2,1,varargin{1}*2/FltConf.Fs,'low');
         FltConf.flag = 1;
    case "nofilter"
        FltConf.b = 0;
        FltConf.a = 0;
        FltConf.flag = 0;
    otherwise
        disp(['Filter type "', char(mode), '" is not supported!']);
        FltConf.b = 0;
        FltConf.a = 0;
        FltConf.flag = 0;
        return
end



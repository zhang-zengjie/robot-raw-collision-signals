function [DataOut] = PrePrcs(MsrExtTrq, DataStillSpl, FltConf)
%PREPRCS Summary of this function goes here
%   Detailed explanation goes here

DataStillMean = mean(DataStillSpl);
DataOut = MsrExtTrq - repmat(DataStillMean,max(size(MsrExtTrq)),1);

if FltConf.flag == 1
    for i = 1:7
        DataOut(:,i) = filter(FltConf.b, FltConf.a, DataOut(:,i));
    end
end

end


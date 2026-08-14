RtPath = ['/home/jerry/Workspace/J12rcml','/DBshare/mat/OnlineTest'];
%addpath([RtPath,'/mfnts'])
addpath('mfnts')
% Hyper-parameter list for segmentation:
% 1. Joint selection;
% 2. Segmentation window size;
% 3. Window bias;
% 4. Window style;
% 5. Window chopping marks.


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% If you extract features
%    
fl = GenList(RtPath);
IFeature = [2, 12, 9, 4, 15, 1, 5, 3, 18, 6, 17, 14, 7, 16, 10, 11, 13, 8];
[FtrsOut, Tims] = GenFtrOnline(fl.DirCtc(7), SetSegConf([1 1 1 1 1 1 1]', 500, 0, @rectwin, [0.4, 1]), ...   
                            SetFtrConf("feature", IFeature([1,2,4,9,10,11,12,13,15,16,18]), ...
                                0, 5, 500, 15, 40, 0.5), ...
                            SetFltConf("nofilter", 100), ...
                            RtPath, "2D");
                        
csvwrite('../csv/Samples/online/contact7_ftr.csv', FtrsOut);

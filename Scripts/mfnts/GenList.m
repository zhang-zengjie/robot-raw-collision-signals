% GenList Generate data repository lists
%   Author: Jerry (Zengjie) Zhang
%   Date: 2018.11.23
%
% Function prototype:
%   s = GenList(RtPath);
%
% Parameter(s):
%   'RtPath' stores the root directory of the database;
%
% Returned value(s):
%   's' is the structure of data dir handle with the following definition:
%
%   1. 's.DirCls', string array, stores the list of directories that contain
%   collision MAT-file data; note that the list starts from the second 
%   element, while the first is its title: "List of collisions";
%   2. 's.DirCtc', string array, stores the list of directories that contain
%   contact MAT-file data; note that the list starts from the second 
%   element, while the first is its title: "List of collisions";
%   3. 's.CntCls', double array, stores the amount of labeled collisions in
%   each 'JK_moments.mat' file;
%   4. 's.CntCtc', double array, stores the amount of labeled contacts in
%   each 'JK_moments.mat' file;
%   5. 's.CntFre', double array, stores the amount of labeled free cases in
%   each 'JK_moments.mat' file;
%   6. 's.NCls' is the total number of collisions;
%   7. 's.NCtc' is the total number of contacts;
%   8. 's.NFre' is the total number of free motions.
%
% Conditions that must be satisfied:
%   1. 'FldName' must obay 3-layer hierarchy;
%   2. 1-level directory list must contain 'Collision' and 'Contact';
%   3. 2-level directory list must not have files;
%   4. 3-level directory must only contain MAT-files.

function s = GenList(FldPath)

s.DirCls = string.empty;
s.DirCtc = string.empty;
s.CntCls = double.empty;
s.CntCtc = double.empty;
s.CntFre = double.empty;

IdxCls = 0;
IdxFre = 0;
IdxCtc = 0;

disp('Generating file lists ...');

L1Lst1 = dir([FldPath, '/Collisions']);
for j = 3:max(size(L1Lst1))
    id = [FldPath, '/Collisions/', L1Lst1(j).name];
    if exist([id, '/JK_moments.mat'],'file') == 2
        IdxCls = IdxCls + 1;
        IdxFre = IdxFre + 1;
        Jm = load([id, '/JK_moments.mat']);
        s.DirCls(IdxCls) = id;
        s.CntCls(IdxCls) = max(size(Jm.JK_moments));
        s.CntFre(IdxFre) = s.CntCls(IdxCls)-1;
    else
        disp(['File JK_moments.mat does not exist in :', id, '... Aborted.']);
        return
    end
end

L1Lst2 = dir([FldPath, '/Contacts']);
for j = 3:max(size(L1Lst2))
    id = [FldPath, '/Contacts/', L1Lst2(j).name];
    if exist([id, '/JK_moments.mat'],'file') == 2
        IdxCtc = IdxCtc + 1;
        IdxFre = IdxFre + 1;
        Jm = load([id, '/JK_moments.mat']);
        s.DirCtc(IdxCtc) = id;
        s.CntCtc(IdxCtc) = max(size(Jm.JK_moments));
        s.CntFre(IdxFre) = s.CntCtc(IdxCtc)-1;
    else
        disp(['File JK_moments.mat does not exist in :', id, '... Aborted.']);
        return
    end
end
    
fprintf('\b');
disp(' Complete.');

s.NCls = sum(s.CntCls);
s.NCtc = sum(s.CntCtc);
s.NFre = sum(s.CntFre);

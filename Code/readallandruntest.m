%%This script creates student score matrices of year 2015 and 2016.
clear;
clc;
tar = {'4104','4204','3204','5304'};
%oridataset={};
for i = 1:size(tar, 2)
%tar: department code
%max: 2016 score , old 2015 score
oridatasetnew{i} = readdepart(tar{i}, 'max');
oridatasetold{i} = readdepart(tar{i}, 'old');
disp('...Done');
end

function ans = readdepart(tar, new)
    rec1k = [];%ppca
    rec2k = [];%ls
    rec3k = [];%row
    rec4k = [];%col
 %test miss rate
    rec1m = [];
    rec2k = [];
    rec3k = [];
    rec4k = [];
 %s1 should be the path of the student score folder.
    s1 = 'C:\Users\User\Desktop\School Works\Project\matlabcode\data\';
    s2 = tar;
 %s3='\max\' or '\old\;
    s3 = new;
    s4 = strcat(s1, s2, '\', s3, '\');
    a = dir(s4);
    s5 = strcat(s4, a(3).name);
    [all, notmerge, merge, PRequation, PRranking, info] = readtostruct(s5);
 

    ans.mergeori = merge;
 %oridataset(i).mergety=mergeryf;
 %oridataset(i).mmisrate=mmisrate;
    ans.nmergeori = notmerge;
% oridataset(i).nmergety=nmergeyf;
 %oridataset(i).nmissrate=rmissrate;
    ans.mergeByEquation = PRequation;
    ans.mergeByRanking = PRranking;
    ans.info = info;
end

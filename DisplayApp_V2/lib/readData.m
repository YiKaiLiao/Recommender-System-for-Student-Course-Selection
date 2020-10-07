clear;
clc;
tar = {'4104','4204','3204','5304'};
for i = 1:size(tar, 2)
%tar: department code
%max: 2016 score , old 2015 score
data{i} = readdepart(tar{i});
disp('...Done');
end

function ans = readdepart(tar)
    rec1k = [];%ppca
    rec2k = [];%ls
    rec3k = [];%row
    rec4k = [];%col
 %test miss rate
    rec1m = [];
    rec2k = [];
    rec3k = [];
    rec4k = [];
 %s1 is the path of the score data folder.
    s1 = '..\data\';
    s2 = tar;
 %s3='\max\' or '\old\;
    s4 = strcat(s1, s2, '\');
    files = dir(s4);
    for j = 3:size(files)
        s5 = strcat(s4, files(j).name);
        [all, notmerge, merge, PRequation, PRranking, info] = readtostruct(s5);
        ans{j-2}.mergeori = merge;
        ans{j-2}.nmergeori = notmerge;
        ans{j-2}.mergeByEquation = PRequation;
        ans{j-2}.mergeByRanking = PRranking;
        ans{j-2}.info = info;
    end
end

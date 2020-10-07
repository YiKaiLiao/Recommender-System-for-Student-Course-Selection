%Convert the students score of a major(.csv file) into matlab format(.m file). 
%M=readmix_csv('/media/yuren/D/104score2.csv',',');
%M=readmix_csv('/media/yuren/D/other/pcaworkstation/allstuscore/1204/400120.csv',',');
function [all, notmerge, merge, PRequation, PRranking, info] = readtostruct(path)
M = readmix_csv(path, ',');
[m, n] = size(M);
t = cellfun(@str2num, M(2:m, 1:n));
s.name = M(1, :);
s.v = t;
s1.name = M(1, 2:end);
s1.v = t(:, 2:end);
oriM = s1;
all = oriM.v;
%Ma = mergesub(s);
t1 = oriM.v;
%td = sum(isnan(t1),2)>=(size(oriM.v,2)*0.6);
%t1(td,:)=[];
s2 = s1.name(:, sum(~isnan(t1))>=10);
t2 = t1(:, sum(~isnan(t1))>=10);

% j=6.5;
% while(isempty(t2))
%  t1=oriM.v;
%  t1(sum(isnan(t1'))>(size(oriM.v,2)*(j*0.1)),:)=[];
%  t2=oriM.v(:,sum(~isnan(t1))>15);
%  j=j+0.5;
%  if(j==8.5)
%      break;
%  end
%  
% end
notmerge = t2;
info.notmergecourename = s2;
mrate = sum(sum(isnan(notmerge)))/(size(notmerge, 1)*size(notmerge, 2));
missrate = mrate;

mt = mergesub(s, 0); %set byPR=0 to merge by normalization.
mergematrix = mt.v;
td = sum(isnan(mergematrix), 2) > (size(mergematrix, 2)*0.8);
mergematrix(td, :) = [];
merge = mergematrix(:, sum(~isnan(mergematrix))>=10);
s3 = mt.name;
info.mergecourename = s3(:, sum(~isnan(mergematrix))>=10);
info.mean = mt.mean;
info.sigma = mt.sigma;

mt_equation = mergesub(s, 1); %set byPR=1 to merge by PR equation.
mergematrix = mt_equation.v;
td = sum(isnan(mergematrix), 2) > (size(mergematrix, 2)*0.8);
mergematrix(td, :) = [];
PRequation = mergematrix(:, sum(~isnan(mergematrix))>=10);

mt_ranking = mergesub(s, 2); %set byPR=2 to merge by PR ranking.
mergematrix = mt_ranking.v;
td = sum(isnan(mergematrix), 2) > (size(mergematrix, 2)*0.8);
mergematrix(td, :) = [];
PRranking = mergematrix(:, sum(~isnan(mergematrix))>=10);

infot = strsplit(path, '\');
ti = infot(end-2:end);
info.id = ti([1, 3]);
info.missrate = missrate;
end
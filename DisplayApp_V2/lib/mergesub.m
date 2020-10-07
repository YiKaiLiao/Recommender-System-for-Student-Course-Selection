%Merge student scores.
%ans = mergesub(s,byPR)
%merge by PR equation if byPR = 1, by ranking if byPR = 2; default as byPR = 0.
function ans = mergesub(s,byPR)
    if nargin < 2
        byPR = 0; 
    end
    v = s.v;
    name = s.name;
    [m,n] = size(v);
    tai = 1;
    tai2 = 1;
    ta = {};
    tb = {};
    disjointset = {};
    needproce = [1:n];
    name1 = name(needproce);
    %先把所有重複的科目放到�?相交集�?�
    while(size(needproce,2) > 1)
        name1 = name(needproce);
        v1 = v(:, needproce);
        % t={'subject id','subject name','semester','class'}
        % t={'4100003','math1','1','1'}
        % find the same subject name return index of name
        t = strsplit(name1{2}, '@');
        a = strfind(name1, t(2));
        needdelet = [];
        tai = 1;
        smalldisjointset = {};
        for j = 1:size(a, 2)
            tar = strsplit(name1{j}, '@');
            if a{j} > 1 & strcmp(tar{2}, t{2})
                needdelet = [needdelet, j];
                smalldisjointset{tai}.name = name1{j};
                smalldisjointset{tai}.v = v1(1:end,j);
                tai = tai + 1;
            end
        end
        needproce(needdelet) = [];
        disjointset{tai2} = smalldisjointset;
        tai2 = tai2 + 1;     
    end
    mergematrix = [];
    rname = [];
    mean = [];
    sigma = [];
    for i = 1:size(disjointset, 2)
        combinematrix = [];
        for j = 1:size(disjointset{i}, 2)
            notnanind = ~isnan(disjointset{i}{j}.v);
            arr = disjointset{i}{j}.v;
            if byPR == 1
                arr(notnanind) = PRequation(disjointset{i}{j}.v(notnanind));
                %disp(arr);
            elseif byPR == 2
                arr(notnanind) = PRranking(disjointset{i}{j}.v(notnanind));
            else
                [arr(notnanind), MU, SIGMA] = zscore(disjointset{i}{j}.v(notnanind));
                mean = [mean MU];
                sigma = [sigma SIGMA];
            end
            combinematrix = [combinematrix, arr];
           % zscore(disjointset{i}(~isnan(v(:,ta1(tw))),ta1(tw)));
        end
        if size(disjointset{i}, 2) == 1
            tempmatrix = combinematrix';
        else
            [tmax,tidx] = max(combinematrix');
            tempmatrix(:) = disjointset{i}{j}.v;
            tempmatrix = tmax ;
        end
        mergematrix = [mergematrix, tempmatrix'];
        rname{i} = disjointset{i}{1}.name;
    end
    ans.name = rname;
    ans.v = mergematrix;
    ans.mean = mean;
    ans.sigma = sigma;
end
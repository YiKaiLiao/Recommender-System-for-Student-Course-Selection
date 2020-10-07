%addpath('/media/yuren/D/app/matlab/matwork/PCAMV');
%ç§»é™¤å¤§ä?å¤§å?
%ddataset = {oridatasetnew{4}, oridatasetnew{3}, oridatasetnew{2}, oridatasetnew{1}};
missing4Result = runmissing4g(ddataset, 1);
function ans = runmissing4g(dataset, merge, R)
    ans = {};
    %size(dataset,2)
    for i = 4:4%:size(dataset, 2)
        resppca = [];
        resmatlab = [];
        resstu = [];
        rescour = [];
        resls = []; 
    
        rrppca = {};
        rrstu = {};
        rrcour = {};
        rrls = {};
        rrankp = {};
        rranks = {};
        rrankc = {};
        rrmap = [];
        ifo = {};
        %for i1=1:1
        %?¯ä»¥ä¸??¨æ?æº–å?
        if merge == 1
            [testy, ymean, ysigma] = nanzscore(dataset{1, i}.twograde.score);
        else
            testy = dataset{i}.nmergeori;
        end
        
        %for i2=1:1
        tifo = {};
        rppca = [];
        rstu = [];
        rcour = [];
        courPred = {};
        
        rls = [];
        rmap = [];
        rankp = [];
        rankc = [];
        ranks = [];
        %out = pca_full( ty', 1 );
        %size(ty, 2);
        ty = testy;
        ty(1:dataset{1, i}.twograde.grade1num, dataset{1, i}.twograde.cour4) = NaN; %remove the old data's senior year scores
        tymiss = isnan(ty);
        testyobs = ~isnan(testy);
        comparepart = tymiss .* testyobs; %comparepart: !originalNAN ^ removedNAN
        comparepart = (comparepart == 1);
        for i3 = 1:max(size(testy))
            fprintf('i=%d  k=%d \n', i, i3);
            %[ W, X, Mu, V, CV, HP, LC ] = pca_full(  ty, i3 ,'algorithm', 'ppca','verbose',0);
            %res1=[];
            if(i3 <= size(testy, 2))
                try
                    [coeff, score, pcvar, mu, v, S] = ppca2(ty, i3);
                    res1 = S.Recon;
                    %res1=score*coeff'+mu;
                    res2 = ty;
                    res2(comparepart) = res1(comparepart); %fill in the missing values of the removed 3rd grade scores
                    rppca = [rppca (immse(testy(comparepart), res2(comparepart) )).^0.5];
                    
                catch
                    rppca = [rppca NaN];
                end
            end
            %[coeff,score,pcvar,mu,v,S] = ppca(ty,i3);
            %WTW = W'*W;
            %Y_hat = W/(WTW)*(WTW+V)*X; % Centered, will add bias term back later
            %res1=(W*X+Mu);
             
            if(i3 < size(testy, 1))
                try
                    %[~,kstu]=min(R.mergeres{i}.cour);
                    res1 = stufill2(ty, i3);
                    rstu = [rstu (immse(testy(comparepart), res1(comparepart) )).^0.5];
                catch
                    rstu = [rstu NaN];
                end
            end
            
            if(i3 <= size(testy, 2))
                try
                    % [~,kcour]=min(R.mergeres{i}.stu); 
                    res3 = courfill2(ty, i3);
                    rcour = [rcour (immse(testy(comparepart), res3(comparepart) )).^0.5];
                    courPred{i3} = res3(comparepart)*ysigma+ymean;
                catch
                    rcour = [rcour NaN];
                    courPred{i3} = NaN;
                end
            end
            %{1,1~1,tylen}
        end
        %{1,1~1,10}
        %end
        info = {'csie', 'me', 'lr', 'im'};
        %comm={'? å…¥?¤æ–·?†æ•¸?’å??å·®è?'}
        t = {};
        t.ppca = (rppca);
        t.stu = (rstu);
        t.cour = (rcour);
        t.info = info{i};
        t.courRslt = (courPred);
        t.answer = testy(comparepart)*ysigma+ymean;
        ans{i} = t;
   end
end
%test randomly missing 20%   
%sdataset : 學生資料 
% merge: 1 not merge: 2 
normalizationResult = run10test(oridatasetnew, 0);
%equationResult = run10test(oridatasetnew, 1);
%rankingResult = run10test(oridatasetnew, 2);
%nonmergedResult = run10test(oridatasetnew, 3);

function ans = run10test(dataset, merge, R)
    ans = {};
    %size(dataset,2)
    for i = 1:size(dataset, 2)
        resppca = [];
        resmatlab = [];
        resstu = [];
        rescour = [];
        resls = []; 
        resproc = [];
        rrppca = [];
        rrstu = [];
       
        rrcour = [];
        rrls = [];
        rrmap = [];
        ifo = {};
        
        
        
        if merge == 0
            testy = dataset{i}.mergeori;
                % testy(:,2)=[];
                %testy=zscore(dataset);
        elseif merge == 1
            testy = dataset{i}.mergeByEquation;
        elseif merge == 2
            testy = dataset{i}.mergeByRanking;
        else
            testy = dataset{i}.nmergeori;
        end
        rrproc = [];
        
        
        
        for i2 = 1:10          
            tifo = {};
            rppca = [];
            rstu = [];
            rcour = [];
            rls = [];
            rmap = [];
            rproc = [];
            %missing 20 percent of the data
            ty = missingdata(testy, 20);
            tymiss = isnan(ty);
            testyobs = ~isnan(testy);
            comparepart = tymiss.*testyobs;
            comparepart = (comparepart == 1);
            smalllaten = min(size(ty));
            obs = ~isnan(testy);
            misspart = isnan(testy);
        
            for i3 = 1:max(size(testy))
                fprintf('i=%d fold=%d k=%d \n', i, i2, i3);
                %如須測ppca latent variable數，把if拿掉
                
                if (i3 < 30)% i3 == 1
                    try
                        [coeff, score, pcvar, mu, v, S] = ppca2(ty, i3);
                        res1 = S.Recon;
                        res2 = testy;
                        res2(isnan(res2)) = res1(isnan(res2));
                        ppca_rmse = (immse(testy(comparepart), res1(comparepart))).^0.5;
                        rppca = [rppca ppca_rmse]; 
                        
                        % square root of mean squared error --> rmse
                    catch
                        rppca = [rppca NaN];
                    end
                    
                end
            
                if(i3 < size(testy, 1))
                    try
                        res2 = stufill2(ty,i3);
                        stu_rmse = (immse(testy(comparepart), res2(comparepart) )).^0.5;
                        rstu = [rstu stu_rmse];
                    catch
                        rstu = [rstu NaN];
                    end
                end
            
                if(i3 < size(testy, 2))
                    try
                        res3 = courfill2(ty, i3);
                        cour_rmse = (immse(testy(comparepart), res3(comparepart) )).^0.5;
                        rcour = [rcour cour_rmse];
                    catch
                        rcour = [rcour NaN];
                    end
                end
            %{1,1~1,tylen}
            end 
            %ifo2{i2}=tifo;
            rrppca = [rrppca;(rppca)];
            rrstu = [rrstu; (rstu)];
            rrcour = [rrcour; (rcour)];
            rrproc = [rrproc; rproc];
        end
        %if0{i1}=ifo2;
        resppca = [resppca nanmean(rrppca)];
        resstu = [resstu nanmean(rrstu)];
        rescour = [rescour nanmean(rrcour)];
        % resproc = [ resproc nanmean(rrproc)];
        %resls = [resls nanmean(rrls)];
        %end
        %an.ppca = resppca;
        %an.resstu = resstu;
        %an.rescour = rescour;
        %an.matlab=resmatlab;
        t = {};
        t.info = dataset{i}.info;
        %t.ifo = if0;
        %t.missrate = 20; 
        t.ppca = (resppca);
        t.stu = (resstu);
        t.cour = (rescour);
        %t.proc = resproc;
        %t.info = dataset{i}.info.id;
        %t.ls = (resls);
        ans{i} = t;
    end
end

%%Randomly discard 20% of the data.
%%Compute rmse values for ppca,knn course, and knn studeny, respectively.
%%fill the missing values in the original student score matrix.
Result = fillMissingValue(oridatasetold, 0);

function result = fillMissingValue(dataset, merge)
    result = {};
    %size(dataset,2)
    for i = 1:size(dataset, 2)
        resppca = [];
        resstu = [];
        rescour = [];
        
        ppcaPred = [];
        courPred = [];
        stuPred = [];
        
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
        
        
        rppca = [];
        rstu = [];
        rcour = [];
        %missing 20 percent of the data
        ty = missingdata(testy, 20);
        tymiss = isnan(ty);
        testyobs = ~isnan(testy);
        comparepart = tymiss.*testyobs;
        comparepart = (comparepart == 1);
        
        for k = 1:max(size(testy))
            fprintf('i=%d k=%d \n', i, k);
            %如須測ppca latent variable數，把if拿掉
            
            if (k < 30)% i3 == 1
                try
                    [coeff, score, pcvar, mu, v, S] = ppca2(ty, k);
                    res1 = S.Recon;
                    res2 = testy;
                    res2(isnan(res2)) = res1(isnan(res2));
                    ppca_rmse = (immse(testy(comparepart), res1(comparepart))).^0.5;
                    rppca = [rppca ppca_rmse]; 
                    % square root of mean squared error --> rmse
                    if k == 1
                        ppca_min = ppca_rmse;
                        ppcaPred = res2;
                    else
                        if ppca_min > ppca_rmse
                            ppca_min = ppca_rmse;
                        end
                    end
                catch
                    rppca = [rppca NaN];
                end
            end
            
            if(k < size(testy, 1))
                try
                    res2 = stufill2(ty,k);
                    stu_rmse = (immse(testy(comparepart), res2(comparepart) )).^0.5;
                    rstu = [rstu stu_rmse];
                    if k == 1
                        stu_min = stu_rmse;
                        stuPred = res2;
                    else
                        if stu_min > stu_rmse
                            stu_min = stu_rmse;
                        end
                    end
                catch
                    rstu = [rstu NaN];
                end
            end
            
            if(k < size(testy, 2))
                try
                    res3 = courfill2(ty, k);
                    cour_rmse = (immse(testy(comparepart), res3(comparepart) )).^0.5;
                    rcour = [rcour cour_rmse];
                    if k == 1
                        cour_min = cour_rmse;
                        courPred = res3;
                    else
                        if cour_min > cour_rmse
                            cour_min = cour_rmse;
                        end
                    end
                catch
                    rcour = [rcour NaN];
                end
            end
        end
        
        t = {};
        t.info = dataset{i}.info;
        t.ppca = (rppca);
        t.stu = (rstu);
        t.cour = (rcour);
        t.ppcaPre = ppcaPred;
        t.stuPre = stuPred;
        t.courPred = courPred;
        t.original = testy;
        t.ppcamin = ppca_min;
        t.courmin = cour_min;
        t.stumin = stu_min;
        result{i} = t;
    end
end

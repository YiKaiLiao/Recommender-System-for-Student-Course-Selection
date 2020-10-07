%%Compute rmse values for ppca,knn course, and knn studeny, respectively.
function result = predictStudentScore(index, department, fileIdx, method, data, merge)
    f = waitbar(0,'','Name','Predicting Scores');
    result = {};
    %size(dataset,2)
    resppca = [];
    resstu = [];
    rescour = [];
    
    ppcaPred = [];
    courPred = [];
    stuPred = [];
    if merge == 0
        testy = data{department}{fileIdx}.mergeori;
    else
        testy = data{department}{fileIdx}.nmergeori;
    end
    rppca = [];
    rstu = [];
    rcour = [];
    ty = missingdata(testy, 20);
    tymiss = isnan(ty);
    testyobs = ~isnan(testy);
    comparepart = tymiss.*testyobs;
    comparepart = (comparepart == 1);
    total = max(size(testy));
    for k = 1:max(size(testy))
        waitbar(k/total, f);
        %如須測ppca latent variable數，把if拿掉
        
        if(k < 30 && method == 1)% i3 == 1
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
                else
                    if ppca_min > ppca_rmse
                        ppca_min = ppca_rmse;
                        ppcaPred = res2;
                        fprintf('min K:%d\n', k);
                    end
                end
            catch
                rppca = [rppca NaN];
            end
        end
        
        if(k < size(testy, 1) && method == 2)
            try
                [res2, neighbors] = NNstudents(ty, k, index);
                stu_rmse = (immse(testy(comparepart), res2(comparepart) )).^0.5;
                rstu = [rstu stu_rmse];
                if k == 1
                    stu_min = stu_rmse;
                else
                    if stu_min > stu_rmse
                        stu_min = stu_rmse;
                        stuPred = res2;
                        NNeighbors = neighbors;
                    end
                end
            catch
                rstu = [rstu NaN];
            end
        end
        
        if(k < size(testy, 2) && method == 3)
            try
                res3 = courfill2(ty, k);
                cour_rmse = (immse(testy(comparepart), res3(comparepart) )).^0.5;
                rcour = [rcour cour_rmse];
                if k == 1
                    cour_min = cour_rmse;
                else
                    if cour_min > cour_rmse
                        cour_min = cour_rmse;
                        courPred = res3;
                    end
                end
            catch
                rcour = [rcour NaN];
            end
        end
    end
    t = {};
    t.info = data{department}{fileIdx}.info;
    t.original = testy;
    if method == 1
        t.ppcamin = ppca_min;
        t.ppca = (rppca);
        t.nanIdx = find(isnan(testy(index, :)));
        testy(find(isnan(testy))) = ppcaPred(find(isnan(testy)));
        t.Pred = testy;
    elseif method == 2
        t.stumin = stu_min;
        t.stu = (rstu);
        t.NN = NNeighbors;
        t.nanIdx = find(isnan(testy(index, :)));
        testy(find(isnan(testy))) = stuPred(find(isnan(testy)));
        t.Pred = testy;
    elseif method == 3
        t.courmin = cour_min;
        t.cour = (rcour);
        t.nanIdx = find(isnan(testy(index, :)));
        testy(find(isnan(testy))) = courPred(find(isnan(testy)));
        t.Pred = testy;
    end
    result = t;
    delete(f);
end
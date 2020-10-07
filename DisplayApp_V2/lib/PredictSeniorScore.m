function ans = PredictSeniorScore(department, method, dataset) 
    f = waitbar(0,'','Name','Predicting Scores');
    ans = {};
    rppca = [];
    rstu = [];
    rcour = [];
    ppcaPred = [];
    courPred = [];
    stuPred = [];
    
    testy = dataset{1, department}.twograde.score;
    ty = testy;
    ty(1:dataset{1, department}.twograde.grade1num, dataset{1, department}.twograde.cour4) = NaN; %remove the old data's senior year scores
    tymiss = isnan(ty);
    testyobs = ~isnan(testy);
    comparepart = tymiss .* testyobs; %comparepart: !originalNAN ^ removedNAN
    comparepart = (comparepart == 1);
    
    total = max(size(testy));
    for i3 = 1:max(size(testy))
        waitbar(i3/total, f);
        if(i3 <= size(testy, 2) && method == 1)
            try
                [coeff, score, pcvar, mu, v, S] = ppca2(ty, i3);
                res1 = S.Recon;
                res2 = ty;
                res2(comparepart) = res1(comparepart); %fill in the missing values of the removed 3rd grade scores
                ppca_rmse = (immse(testy(comparepart), res2(comparepart) )).^0.5;
                rppca = [rppca ppca_rmse];
                if i3 == 1
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
        
        if(i3 < size(testy, 1) && method == 2)
            try
                %[~,kstu]=min(R.mergeres{i}.cour);
                res1 = stufill2(ty, i3);
                stu_rmse = (immse(testy(comparepart), res1(comparepart) )).^0.5;
                rstu = [rstu stu_rmse];
                if i3 == 1
                    stu_min = stu_rmse;
                else
                    if stu_min > stu_rmse
                        stu_min = stu_rmse;
                        stuPred = res2;
                    end
                end
            catch
                rstu = [rstu NaN];
            end
        end
        
        if(i3 <= size(testy, 2) && method == 3)
            try
                % [~,kcour]=min(R.mergeres{i}.stu);
                res3 = courfill2(ty, i3);
                cour_rmse = (immse(testy(comparepart), res3(comparepart) )).^0.5;
                rcour = [rcour cour_rmse];
                if i3 == 1
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
    
    info = {'cs', 'me', 'lr', 'im'};
    t = {};
    if method == 1
        t.ppcamin = ppca_min;
        t.ppca = (rppca);
        testy(comparepart) = ppcaPred(comparepart);
        t.Pred = ppcaPred;
    elseif method == 2
        t.stumin = stu_min;
        t.stu = (rstu);
        testy(comparepart) = stuPred(comparepart);
        t.Pred = stuPred;
    elseif method == 3
        t.courmin = cour_min;
        t.cour = (rcour);
        testy(comparepart) = courPred(comparepart);
        t.Pred = courPred;
    end
    t.ppca = (rppca);
    t.stu = (rstu);
    t.cour = (rcour);
    t.info = info{department};
    t.compare = comparepart;
    notMergenameOnly = [];
    for i=1:size(dataset{1, department}.twograde.courename, 2)
        x = strsplit(dataset{1, department}.twograde.courename{i},'@');
        notMergenameOnly = [notMergenameOnly, x(2)];
    end
    t.name = notMergenameOnly;
    ans = t;
    delete(f);
end
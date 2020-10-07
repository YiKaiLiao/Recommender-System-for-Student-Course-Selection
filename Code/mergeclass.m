%合併不同屆學生 須配合 readallandruntest  和課程地圖 http://coursemap.ccu.edu.tw/dept_info.php?deptcd=4104
for i = 1:size(tar, 2)
    ddataset{i} = mergeclasses(i, oridatasetold, oridatasetnew);
end

function ans = mergeclasses(dep, oldData, newData)
    a1 = [];
%mergeclassset={}
    for i = 1:size(oldData{1, dep}.info.notmergecourename,2) %find the indices of the same non-merged courses
        %a1=[a1 oridataset.info.mergecourename(1)];
        a1 = [a1 find(strcmp(oldData{1, dep}.info.notmergecourename(1,i), newData{1, dep}.info.notmergecourename(1,:))==1)];
    end
    rs = [];
    info = {};
    courrs = [];
    for i = 1:size(a1, 2) 
        temp = [];
        temp = [temp; oldData{1, dep}.nmergeori(:, i)]; %temp: scores of the identical non-merged courses
        courrs = [courrs newData{1, dep}.info.notmergecourename(:, a1(i))]; %courrs: name of the identical non-merged courses
        temp = [temp; newData{1, dep}.nmergeori(:, a1(i))];
        rs = [rs temp];
    end
    twograde = {};
    twograde.courename = courrs;
    twograde.score = rs;
    twograde.grade1num = size(oldData{1, dep}.nmergeori(:, i), 1);
%配合課程地圖 ex: mec={'專題實驗（二）','網路安全概論','影像處理概論','嵌入式系統軟體設計與實作'}
    ans = {};
    load('mec');
    switch dep
        case 1
            mec = mecc{1};%{'專題實驗（二）','網路安全概論', '計算機結構', '多媒體系統', '微處理機應用設計', '微處理機應用設計', '近代數位系統設計', '個人軟體程序程式', '資料庫系統', '電信網路概論', '超大型積體電路系統設計概論', 'Java程式設計', '嵌入式系統軟體設計與實作', '影像處理概論', '網路程式設計'};
            ans.name = '資工';
        case 2
            mec = mecc{2};%{'機電專題實作', 'CNC製造聯網整合技術', '嵌入式控制器設計', '專利寫作理論與實務', '創意工程設計', '專利侵害鑑定理論與實務', '精密工具機技術', '應用光學與實務', '數值方法', '機械工程與綠色科技', '工具機概論'};
            ans.name = '機械';
        case 3
            mec = mecc{3};%{'論文撰寫'};
            ans.name = '勞工';
        case 4
            mec = mecc{4};%{'策略資訊管理', '顧客關係管理', '電子化供應鏈管理', '資訊管理個案研究', '資料探勘與應用'};
            ans.name = '資管';
    end
    cour4 = [];
    for i = 1:size(rs, 2)
        temp = split(twograde.courename(i), '@');
        if(find(strcmp(temp(2), mec) == 1))
            cour4 = [cour4 i];
        end
    end
    twograde.cour4 = cour4;
    ans.twograde = twograde;
end
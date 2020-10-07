%畫出準確率結果 
%對應sdataset 第 i 科系 一次畫一個科系
i=2;
i=2;

%n=size(miss10to80_415{1, 1}.ppca,2);
%dataset=run10fol87{1,4};
dataset=run10fol87_toba{1, i};
np=size(dataset.ppca,2);
nc=size(dataset.cour,2);
ns=size(dataset.stu,2);
%te=dataset.ppca{1,2};
ppcaone=dataset.ppca(1)*ones(1,ns);
%r2=r1*run10foldres48.mergeres{1, i}.ppca(1);
%r3=r1*meran7231{1, i}.ls;  
hold;
%plot([1:n2],r3,'m','DisplayName','ls');
plot([1:size(dataset.ppca,2)],dataset.ppca,'r','DisplayName','ppca');
plot([1:nc],dataset.cour,'b','DisplayName','knn-cour');
plot([1:ns],dataset.stu,'b--o','DisplayName','knn-stu');

function ans=samerank(ori,test)
[a1 ,a2]=sort(ori,'descend');
[b1, b2 ]=sort(test,'descend');
ori1=ori;
test1=test;
ori_soridar=[];
test_soridar=[];
for i=1:max(size(ori))
    id1=find(ori1(i)==a1,1);
    a1(id1)=999;
    ori_soridar=[ori_soridar id1];
    id2=find(test1(i)==b1,1);
    b1(id2)=999;
    test_soridar=[test_soridar id2];
end

ans=sum(abs(ori_soridar-test_soridar))/max(size(ori));
end
clc;
subplot(2,2,1);
t1=1:92;
ppca_vec=ones(1,92)*min(normalizationResult{1}.ppca);
t3=1:38;
plot(t1,normalizationResult{1}.stu,t1,ppca_vec,t3,normalizationResult{1}.cour),xlabel('K'),ylabel('rmse'),title('CS'),legend('knn student','ppca','knn course')

subplot(2,2,2);
t1=1:94;
ppca_vec=ones(1,94)*min(normalizationResult{2}.ppca);
t3=1:51;
plot(t1,normalizationResult{2}.stu,t1,ppca_vec,t3,normalizationResult{2}.cour),xlabel('K'),ylabel('rmse'),title('ME'),legend('knn student','ppca','knn course')

subplot(2,2,3);
t1=1:53;
ppca_vec=ones(1,53)*min(normalizationResult{3}.ppca);
t3=1:37;
plot(t1,normalizationResult{3}.stu,t1,ppca_vec,t3,normalizationResult{3}.cour),xlabel('K'),ylabel('rmse'),title('LR'),legend('knn student','ppca','knn course')

subplot(2,2,4);
t1=1:32;
ppca_vec=ones(1,32)*min(normalizationResult{4}.ppca);
t3=1:25;
plot(t1,normalizationResult{4}.stu,t1,ppca_vec,t3,normalizationResult{4}.cour),xlabel('K'),ylabel('rmse'),title('IM'),legend('knn student','ppca','knn course')
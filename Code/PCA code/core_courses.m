%% Initialization
clear ; close all; clc
%% ================== Part 1: Load Example Dataset  ===================
load ('studata327.mat');

%% =============== Part 2: Principal Component Analysis ===============
fprintf('\nRunning PCA on student dataset.\n\n');

[U,Z,latent,tsquared,explained] = pca(zscore(studata327(1).knnmergey));

%% =============== Part 3:  Calculate retained variance ================
K = 3;
fprintf('\nSet K = %d\n\n',K);
fprintf('\nCalculating variance retained.\n\n');
fprintf('\n= %.2f%%\n\n',sum(explained(1:K)));
%% =============== Part 4:  PCA for Visualization ====================
figure;
biplot(U(:,1:3), 'Scores', Z(:,1:3));
fprintf('Program paused. Press enter to continue.\n');
pause;
%% =============== Part 5:  Component Interpretation ====================
fprintf('First K columns of Matrix U:\n\n');
disp(U(:,1:K));
pause;
fprintf('First K columns of Matrix Z:\n\n');
disp(Z(:,1:K))
pause;
courseNum = length(studata327(1).info.mergecourename);
coreCourses = {};
for pc = 1:34
    [sortedArray, sortedIndex] = sort(U(:,pc),'descend');
    courseOrder = [];
    for i = 1:courseNum
        courseOrder = [courseOrder, studata327(1).info.mergecourename(sortedIndex(i))];
    end
    coreCourses{end+1} = courseOrder;
end
%% =============== Part 6:  Calculate PC scores =======================
load core3;
Scores = [];
for j = 1:34
    Score = 0;
    for i = 1:length(core3)
        index = strcmp(coreCourses{j}, core3{i});
        Score = Score + index*U(j);
        Scores(j) = sum(Score);
    end
end


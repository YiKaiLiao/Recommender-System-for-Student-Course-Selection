%% Initialization
clear ; close all; clc
%% ================== Part 1: Load Example Dataset  ===================
load ('studata327.mat');

%% =============== Part 2: Principal Component Analysis ===============
fprintf('\nRunning PCA on student dataset.\n\n');
[U,Z,latent,tsquared,explained] = pca(PR_Mapping(zscore(studata327(2).knnNmergey)));
fprintf('\nUnmerged Dataset size:\t');
disp(size(studata327(1).knnNmergey));
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
disp(Z(:,1:K));
pause;
courseNum = length(studata327(2).info.notmergecourename);
Ordered = [];
coreCourses = {};
for pc = 1:courseNum
    [sortedArray, sortedIndex] = sort(U(:,pc),'descend');
    courseOrder = [];
    Ordered = [Ordered, sortedArray];
    for i = 1:courseNum
        courseOrder = [courseOrder, studata327(2).info.notmergecourename(sortedIndex(i))];
    end
    coreCourses{end+1} = courseOrder;
end
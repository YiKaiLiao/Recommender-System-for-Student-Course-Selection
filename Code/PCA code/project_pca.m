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
%% =============== Part 5:  Component Interprtation ====================
disp(U(:,1:K));
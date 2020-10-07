function Result = CoreCourses(data, department)
    fprintf('\nRunning PCA on student dataset.\n\n');
    [U,Z,latent,tsquared,explained] = pca(zscore(data.Pred));
    K = 3;
    fprintf('\nSet K = %d\n\n',K);
    fprintf('\nCalculating variance retained.\n\n');
    fprintf('\n= %.2f%%\n\n',sum(explained(1:K)));
    figure(1);
    biplot(U(:,1:3), 'Scores', Z(:,1:3));
    xlabel('PC 1');
    ylabel('PC 2');
    zlabel('PC 3');
    courseNum = length(data.info.notMergenameOnly);
    coreCourses = {};
    sortedCourses = {};
    for pc = 1:size(U, 2)
        [sortedArray, sortedIndex] = sort(U(:,pc),'descend');
        courseOrder = [];
        for i = 1:courseNum
            courseOrder = [courseOrder, data.info.notMergenameOnly(sortedIndex(i))];
        end
        coreCourses{end+1} = courseOrder;
        sortedCourses{end+1} = sortedArray;
    end
    
    load AllCore.mat;
    coreName = {};
    for i = 1:size(AllCore{department}, 2)
        coreName{i} = AllCore{department}{i}.name;
    end
    Result = {};
    Result.UMatrix = U;
    Result.names = coreName;
end

















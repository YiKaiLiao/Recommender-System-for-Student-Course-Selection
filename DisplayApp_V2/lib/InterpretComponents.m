function InterpretComponents(pcaResult, studentScores, courseNames, department)
    load AllCore.mat;
    core = AllCore{department};
    K = 3;
    [, indices] = find(~isnan(studentScores));
    newScores = zeros(size(studentScores));
    newScores(indices) = studentScores(indices);
    Scores = {};
    CoreRatio = {};
    for i = 1:K
        Scores{i} = sum(abs(pcaResult.UMatrix(:, i)).*newScores(:)); 
        proportions = [];
        for j = 1:size(core, 2)
            coreSum = 0;
            for k = 1:size(courseNames,2)
                match = strcmp(courseNames(k), core{j}.courses);
                coreSum = coreSum + abs(pcaResult.UMatrix(k, i))*sum(match);
            end
            proportions = [proportions coreSum];
        end
        CoreRatio{i} = proportions;
    end
    figure(2);
    for l = 1:K
        subplot(3, 1, l);
        pie3(CoreRatio{l});
        legend(pcaResult.names);
        title(['PC ' num2str(l)]);
    end
    
end
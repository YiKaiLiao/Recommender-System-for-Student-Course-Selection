clc
[rows, cols] = size(oridatasetold{1}.mergeByRanking); 
grid = round(sqrt(cols));
for i = 1:cols
    subplot(grid, grid, i);
    X = oridatasetold{1}.mergeByRanking(:,i);
    histplot(X, 30)
    subplot();
end
function singleCourseHistogram(courseIndex, department, fileIdx, data)
    num = size(courseIndex, 1);
    grid = round(sqrt(num));
    for i = 1:num
        if num > grid*grid
            subplot(grid, grid+1, i);
        else
            subplot(grid, grid, i);
        end
        courseIdx = courseIndex(i, 2);
        X = data{department}{fileIdx}.nmergeori(:, courseIdx);
        X = X(~isnan(X));
        bins = floor(log2(size(X, 1)))+1;
        histplot(X, bins);
        subplot();
    end
end
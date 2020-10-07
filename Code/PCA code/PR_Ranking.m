function result = PR_Mapping2(data)
    [row, col] = size(data);
    result = [];
    Ranked = [];
    for i = 1:col
        [temp, Ranked]  = ismember(data(:,i), unique(data(:,i)));
        student_num = length(Ranked);
        Ranked = student_num - Ranked + 1;
        result = [result Ranked];
    end
end
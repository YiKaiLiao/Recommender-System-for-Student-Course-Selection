%%Search for the input ID in the student grading dataset.
function [ans, score, index, coursesName] = searchData(ID, department, data)
    score = [];
    coursesName = [];
    index = -1;
    ans = 0;
    for i = 1:size(data{department}, 2)
        found = find(data{department}{i}.info.studentID == ID);
        if(found > 0)
            ans = i;
            index = found;
            score = data{department}{i}.nmergeori(found,:);
            coursesName = data{department}{i}.info.notMergenameOnly;
            disp('ID found...');
            break;
        end
    end
end
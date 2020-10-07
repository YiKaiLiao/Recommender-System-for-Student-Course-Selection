function newData = scoreMapping(data)
    [row, col] = size(data);
    newData = zeros(row, col);
    for i = 1:row
        for j = 1:col
            if data(i,j)>=90.00
                newData(i,j) = 4.3;
            elseif data(i,j)>=85.00
                newData(i,j) = 4.0;
            elseif data(i,j)>=80.00
                newData(i,j) = 3.7;
            elseif data(i,j)>=77.00
                newData(i,j) = 3.3;
            elseif data(i,j)>=73.00
                newData(i,j) = 3.0;
            elseif data(i,j)>=70.00
                newData(i,j) = 2.7;
            elseif data(i,j)>=67.00
                newData(i,j) = 2.3;
            elseif data(i,j)>=63.00
                newData(i,j) = 2.0;
            elseif data(i,j)>=60.00
                newData(i,j) = 1.7;
            elseif data(i,j)>=50.00
                newData(i,j) = 1.0;
            else
                newData(i,j) = 0.0;
            end
        end
    end


end
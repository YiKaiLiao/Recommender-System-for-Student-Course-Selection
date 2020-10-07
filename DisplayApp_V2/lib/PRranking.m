%Convert raw data into PR value by ranking.
function result = PRranking(data)
    num = size(data,1);
    ranking = floor(tiedrank(data));
    result = (num - ranking)/num; 
end
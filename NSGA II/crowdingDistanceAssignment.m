function [valueOrder] = crowdingDistanceAssignment(rank, rankValues)

    l = length(rank);
    
    distance = zeros(1,l);

for j = 1:length(rankValues{1})
    
    for i = 1:height(rankValues)
        objectiveRankValue(i) = rankValues{i}(j);
    end
    
    [~, sortedValues] = sort(objectiveRankValue);
    
    
    distance(sortedValues(1)) = Inf;
    distance(sortedValues(l)) = Inf;
    
    for i = 2:(l-1)
        
        distance(sortedValues(i)) = distance(sortedValues(i)) + (objectiveRankValue(sortedValues(i+1)) - objectiveRankValue(sortedValues(i+1)))/(max(objectiveRankValue) -  min(objectiveRankValue));
    end
    
end
    
    [~, valueOrder] = sort(distance, 'descend');
    
end
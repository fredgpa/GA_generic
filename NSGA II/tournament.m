function [parent] = tournament(sortedPop, problem)


    random = randperm(problem.n_ind);
    
    chosen = random(1:problem.tournamentSize);
    
    weight = [];
    for i = 1:length(chosen)
        for j = 1:length(sortedPop)
            if ismember(chosen(i), sortedPop{j})
                weight(i) = j;
            end
        end
    end
    
    [~ , sortedWeight] = sort(weight);
    
    parent = chosen(sortedWeight(1));

end


function [child] = crossover (parent1, parent2, dim)

    if objFunction(parent1, dim) < objFunction(parent2, dim)
        priority = parent1;
        secondary = parent2;
    else
        priority = parent2;
        secondary = parent1;
    end

    for i = length(parent1)
        coin = rand();
        
        if coin <= 0.6
            child(i) = priority(i);
        else
            child(i) = secondary(i);
        end
    end


end
function [child] = OnePointCrossover (parent1, parent2, problem)

    point = randi(problem.n_indSize);
    
    child = parent1(1:point-1);
    child = [child parent2(point:end)];

end
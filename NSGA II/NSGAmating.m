function [pop] = NSGAmating(pop, sortedPop, problem)
i=1;


while i <= problem.n_ind
    
    parent1 = tournament(sortedPop, problem);
    
    parent2 = tournament(sortedPop, problem);
    
    child = OnePointCrossover(pop(parent1, :), pop(parent2, :), problem);
    

    pop = [pop; child];
    
    i = i+1;
end


end
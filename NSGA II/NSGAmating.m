function [new_pop] = mating(pop, problem)
i=1;
new_pop = [];

while i <= length(pop(:,1))
    child1 = crossover(pop(i,:),pop(i+1,:), problem);
    child2 = crossover(pop(i+1,:), pop(i,:), problem);
    

    new_pop = [new_pop; child1; child2];
    
    i = i+2;
end


end
function [new_pop] = mating(pop, dim)
i=1;
new_pop = [];

while i <= length(pop)
    child1 = crossover(pop(i,:),pop(i+1,:), dim);
    child2 = crossover(pop(i+1,:), pop(i,:), dim);
    

    new_pop = [new_pop; child1; child2];
    
    i = i+2;
end


end
function [best, time] = NSGAII(problem)

%% ----- instruções de modificação

%criar uma população

%usar um sistema de torneio para selecionar os melhores individuos e fazer
%crossover e mutação

%dividir esses individuos em ranks

%mandar os melhores pra população nova (e usar o crowding distance)

%selecionar os melhores

%repetir até...

%% -----------

 tic
    exit = false;
    pop = [];
    gen = 0;
    best = [];
    
    size = problem.n_ind;
    
    for i = 1:size
        pop = [pop; create_individual(problem.n_indSize)];
    end
    
    value = [];
    for i=1:problem.n_ind
        value = [value; {objFunction(pop(i,:), problem)}];
    end
    
    sortedPop = nonDominanceSorting(pop, value);
    
    while(~exit)
        gen = gen + 1
        
        pop = NSGAmating(pop, sortedPop, problem);
        
        
        
       	value = [];
        for i=1:problem.n_ind*2
            value = [value; {objFunction(pop(i,:), problem)}];
        end
    
        sortedPop = nonDominanceSorting(pop, value);
        
        newPop = [];
        rankTracker = 1;
        while height(newPop) < problem.n_ind
            if problem.n_ind - height(newPop) >= length(sortedPop{rankTracker})
                
                for i = 1:length(sortedPop{rankTracker})
                    newPop = [newPop; pop(sortedPop{rankTracker}(i), :)];
                end
                rankTracker = rankTracker + 1;
            else
                
                rankValues = {};
                for i = 1:length(sortedPop{rankTracker})
                    rankValues = [rankValues; {objFunction(pop(sortedPop{rankTracker}(i),:), problem)}];
                end
                
                valueOrder = crowdingDistanceAssignment(sortedPop{rankTracker}, rankValues);
                
                n = problem.n_ind - height(newPop);
                
                for i = 1:n
                    newPop = [newPop; pop(sortedPop{rankTracker}(valueOrder(i)), 1)];
                end
            end
        end
        
% %         if isempty(best) || (value(new_order(1)) < best.value)
% %             best.ind = pop(new_order(1),:);
% %             best.value = value(new_order(1));
% %             best.gen = gen;
% %         end

        pop = newPop;
                
        if gen == problem.Maxgen
            exit = true;
        end
    end
    
time = toc;

%localSearch(decoder(best, problem), problem);
end
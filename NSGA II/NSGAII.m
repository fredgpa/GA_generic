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
    while(~exit)
        gen = gen + 1
        if isempty(pop)
            for i = 1:size
                pop = [pop; create_individual(problem.n_indSize)];
            end
        else
            %pegar os melhores e crowding distance
            
        end

        
        
        pop = [pop; NSGAmating(pop, problem)];
        
        value = [];
        for i=1:problem.n_ind
            value = [value objFunction(pop(i,:), problem)];
        end
        
        [~, new_order] = sort(value);
        
        if isempty(best) || (value(new_order(1)) < best.value)
            best.ind = pop(new_order(1),:);
            best.value = value(new_order(1));
            best.gen = gen;
        end
        
        pop = sortPop(pop, new_order);
        
        if gen == problem.Maxgen
            exit = true;
        end
    end
    
time = toc;

%localSearch(decoder(best, problem), problem);
end
function [best, time] = BRKGA(problem)
 tic
    exit = false;
    pop = [];
    Elitepop = [];
    NotElitepop = [];
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
            pop = [];
            for i = 1:problem.n_Rand*size
                pop = [pop; create_individual(problem.n_indSize)];
            end
                                   
            %%%%%crossover
            NotElitepop = mating(NotElitepop, problem);
            
            pop = [pop; Elitepop; NotElitepop];
        end
        
            
        
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
        
        Elitepop = [];
        for i = 1:problem.n_Elite*size
            Elitepop = [Elitepop; pop(new_order(i),:)];
        end
        
        NotElitepop = [];
        for i = (problem.n_Elite*size)+1:(problem.n_Elite*size)+(problem.n_NOTelite*size)
            NotElitepop = [NotElitepop; pop(new_order(i),:)];
        end
        
        if gen == problem.Maxgen
            exit = true;
        end
    end
    
time = toc;
end
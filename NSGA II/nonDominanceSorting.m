function [sortedPop] = nonDominanceSorting(pop, value)

    F = [];
    S = [];

    for i = 1:length(pop)
        
        n(i) = 0;
        array = [];
        
        totalI = sum(value{i});
        
        for j = 1:length(pop)
            totalJ = sum(value{j});
            
            if(totalI < totalJ)
                array = [array j];
            elseif(totalI > totalJ)
                n(i) = n(i) + 1;
            end
        end

        S = [S; {array}];
        
        if n(i) == 0
            if isempty(F)
                F = {i};
            else
                F{1} = [F{1} i];
            end
        end
    end
    
    rank = 1;
        
    while( ~isempty(F{rank}))
        
        Q = [];
        for i = 1:length(F{rank})
           for j = 1:length(S{F{rank}(i)})
               %if n(S{F{rank}(i)}(j)) > 0
                   n(S{F{rank}(i)}(j)) = n(S{F{rank}(i)}(j)) - 1;
               %end
               if n(S{F{rank}(i)}(j)) == 0
                   Q(end+1) = S{F{rank}(i)}(j);
               end
           end
        end
        
        
        rank = rank + 1;
        F = [F; {Q}];
    end

    sortedPop = F(1:end-1);
end


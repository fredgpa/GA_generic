function [fx] = objFunction(ind, problem)
    %
    ord = decoder(ind,problem);
    
    ord = localSearch(ord, problem);

    load('Shipyard\cost_table.mat');
    load('Shipyard\material_table.mat');
    
    size = problem.n_indSize;
    
    dim = problem.matrixDim;
    
    constraint = problem.constraints;
    
    f = zeros(1, length(problem.weights));
    
    [check, ord, constraint] = checkConstraints(ord, constraint);
    if check
%%

        distance = zeros(size);
        for i = 1:size
            for j = 1:size
              if i ~= j
                distance(ord(i).n, ord(j).n) = abs(ord(i).centroidX - ord(j).centroidX) + abs(ord(i).centroidY- ord(j).centroidY);
              end
            end
        end

        for i = 1:size
            for j = 1:size
              f(1) = f(1) + costs(ord(i).n, ord(j).n)*materials(ord(i).n, ord(j).n)*distance(ord(i).n, ord(j).n);
            end
        end
        
%%
        for i = 1:size
            achArea = (ord(i).sizeU + ord(i).sizeD) * (ord(i).sizeR + ord(i).sizeL);
            
            f(2) = f(2) + abs(ord(i).reqArea - achArea)/ord(i).reqArea;
        end
%%
        for i = 1:size
            if (ord(i).sizeU + ord(i).sizeD) > (ord(i).sizeR + ord(i).sizeL)
                achAspect = (ord(i).sizeU + ord(i).sizeD) / (ord(i).sizeR + ord(i).sizeL);
            else
                achAspect = (ord(i).sizeR + ord(i).sizeL) / (ord(i).sizeU + ord(i).sizeD);
            end
            
            f(3) = f(3) + abs(ord(i).reqAspect - achAspect);
        end
%%
        for i = 1:size
            for j = i+1:size
                aux = [];
                for k = 1:length(constraint)
                    if constraint(k).checkDept(ord(i).n) && constraint(k).checkDept(ord(j).n)
                        break;
                    end
                end
                
                if ~isempty(k)
                    f(4) = f(4) + constraint(k).reqAdj*(1 - constraint(k).achAdj);
                    
                    f(5)= f(5) + constraint(k).reqAlign*(1 - constraint(k).achAlign);
                end
                
            end
        end
        
        fx = problem.weights.*f;
    else
        fx = Inf;
    end
    %
end
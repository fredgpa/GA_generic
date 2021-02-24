function [departments] = localSearch(departments, problem)

    matrixDim = problem.matrixDim;
    
    deptIndex = 1;
    dir = ["up", "down", "right", "left"];
    
    load('Shipyard\cost_table.mat');
    load('Shipyard\material_table.mat');
    
    horizontalReady = false;
    verticalReady = false;
    
    while(true)
        
        restrained = false;
        
        for i = 1:length(problem.constraints)
            if departments(deptIndex).n == problem.constraints(i).deptA || departments(deptIndex).n == problem.constraints(i).deptB
                restrained = true;
            end
        end
        
        if restrained || ismember(departments(deptIndex).n, problem.fixedDept) || sum(materials(deptIndex, :)) + sum(materials(:, deptIndex)) == 0
            deptIndex = deptIndex + 1;
            horizontalReady = false;
            verticalReady = false;
        else
            costArray = [];
            currentCost = 0;
            for i=1:length(materials(deptIndex,:))
                if materials(deptIndex, i) > currentCost
                    currentCost = materials(deptIndex, i);
                    costArray = i;
                end
            end
            
            for i=1:length(materials(:, deptIndex))
                if materials(i, deptIndex) > currentCost
                    currentCost = materials(deptIndex, i);
                    costArray = i;
                end
            end
            
           
            
            %for i=1:length(costArray)
            if length(costArray) == 1
                i = 1;
                
                if departments(deptIndex).centroidX > departments(costArray(i)).centroidX
                    horizontal = false;
                elseif departments(deptIndex).centroidX < departments(costArray(i)).centroidX
                    horizontal = true;
                end
                
                if departments(deptIndex).centroidY > departments(costArray(i)).centroidY
                    vertical = false;
                elseif departments(deptIndex).centroidY < departments(costArray(i)).centroidY
                    vertical = true;
                end
                
                if horizontal
                    [dist, collision] = detectCollision(departments(deptIndex), dir(3), [departments(deptIndex).sizeU, departments(deptIndex).sizeD, departments(deptIndex).sizeR+1, departments(deptIndex).sizeL], departments, matrixDim);
                    if collision && dist - departments(deptIndex).sizeR <= 1 && dist - departments(deptIndex).sizeR > 0
                        departments(deptIndex).centroidX = departments(deptIndex).centroidX + dist - departments(deptIndex).sizeR;
                        [dist, collision] = detectCollision(departments(deptIndex), dir(3), [departments(deptIndex).sizeU, departments(deptIndex).sizeD, departments(deptIndex).sizeR+1, departments(deptIndex).sizeL], departments, matrixDim);
                    end
                    if dist - departments(deptIndex).sizeR == 0 || (verticalReady && departments(deptIndex).centroidX - departments(deptIndex).sizeL >= departments(costArray(i)).centroidX - departments(costArray(i)).sizeL && departments(deptIndex).centroidX + departments(deptIndex).sizeR <= departments(costArray(i)).centroidX + departments(costArray(i)).sizeR)
                        horizontalReady = true;
                    end
                    while ~collision && ~horizontalReady
                        departments(deptIndex).centroidX = departments(deptIndex).centroidX + 1;
                        [dist, collision] = detectCollision(departments(deptIndex), dir(3), [departments(deptIndex).sizeU, departments(deptIndex).sizeD, departments(deptIndex).sizeR+1, departments(deptIndex).sizeL], departments, matrixDim);
                        if collision && dist - departments(deptIndex).sizeR <= 1 && dist - departments(deptIndex).sizeR > 0
                            departments(deptIndex).centroidX = departments(deptIndex).centroidX + dist - departments(deptIndex).sizeR;
                            [dist, collision] = detectCollision(departments(deptIndex), dir(3), [departments(deptIndex).sizeU, departments(deptIndex).sizeD, departments(deptIndex).sizeR+1, departments(deptIndex).sizeL], departments, matrixDim);
                        end
                        if dist - departments(deptIndex).sizeR == 0 || (verticalReady && departments(deptIndex).centroidX - departments(deptIndex).sizeL >= departments(costArray(i)).centroidX - departments(costArray(i)).sizeL && departments(deptIndex).centroidX + departments(deptIndex).sizeR <= departments(costArray(i)).centroidX + departments(costArray(i)).sizeR)
                            horizontalReady = true;
                        end
                    end
                else
                    [dist, collision] = detectCollision(departments(deptIndex), dir(4), [departments(deptIndex).sizeU, departments(deptIndex).sizeD, departments(deptIndex).sizeR, departments(deptIndex).sizeL+1], departments, matrixDim);
                    if collision && dist - departments(deptIndex).sizeL <= 1 && dist - departments(deptIndex).sizeL > 0
                        departments(deptIndex).centroidX = departments(deptIndex).centroidX - dist + departments(deptIndex).sizeL;
                        [dist, collision] = detectCollision(departments(deptIndex), dir(4), [departments(deptIndex).sizeU, departments(deptIndex).sizeD, departments(deptIndex).sizeR, departments(deptIndex).sizeL+1], departments, matrixDim);
                    end
                    if dist - departments(deptIndex).sizeL == 0 || (verticalReady && departments(deptIndex).centroidX - departments(deptIndex).sizeL >= departments(costArray(i)).centroidX - departments(costArray(i)).sizeL && departments(deptIndex).centroidX + departments(deptIndex).sizeR <= departments(costArray(i)).centroidX + departments(costArray(i)).sizeR)
                        horizontalReady = true;
                    end
                    while ~collision && ~horizontalReady
                        departments(deptIndex).centroidX = departments(deptIndex).centroidX - 1;
                        [dist, collision] = detectCollision(departments(deptIndex), dir(4), [departments(deptIndex).sizeU, departments(deptIndex).sizeD, departments(deptIndex).sizeR, departments(deptIndex).sizeL+1], departments, matrixDim);
                        if collision && dist - departments(deptIndex).sizeL <= 1 && dist - departments(deptIndex).sizeL > 0
                            departments(deptIndex).centroidX = departments(deptIndex).centroidX - dist + departments(deptIndex).sizeL;
                            [dist, collision] = detectCollision(departments(deptIndex), dir(4), [departments(deptIndex).sizeU, departments(deptIndex).sizeD, departments(deptIndex).sizeR, departments(deptIndex).sizeL+1], departments, matrixDim);
                        end
                        if dist - departments(deptIndex).sizeL == 0 || (verticalReady && departments(deptIndex).centroidX - departments(deptIndex).sizeL >= departments(costArray(i)).centroidX - departments(costArray(i)).sizeL && departments(deptIndex).centroidX + departments(deptIndex).sizeR <= departments(costArray(i)).centroidX + departments(costArray(i)).sizeR)
                            horizontalReady = true;
                        end
                    end  
                end
                
                if vertical
                    [dist, collision] = detectCollision(departments(deptIndex), dir(2), [departments(deptIndex).sizeU, departments(deptIndex).sizeD+1, departments(deptIndex).sizeR, departments(deptIndex).sizeL], departments, matrixDim);
                    if collision && dist - departments(deptIndex).sizeD <= 1 && dist - departments(deptIndex).sizeD > 0
                        departments(deptIndex).centroidY = departments(deptIndex).centroidY + dist - departments(deptIndex).sizeD;
                        [dist, collision] = detectCollision(departments(deptIndex), dir(2), [departments(deptIndex).sizeU, departments(deptIndex).sizeD+1, departments(deptIndex).sizeR, departments(deptIndex).sizeL], departments, matrixDim);
                    end
                    if dist - departments(deptIndex).sizeD == 0 || (horizontalReady && departments(deptIndex).centroidY - departments(deptIndex).sizeU >= departments(costArray(i)).centroidY - departments(costArray(i)).sizeU && departments(deptIndex).centroidY + departments(deptIndex).sizeD <= departments(costArray(i)).centroidY + departments(costArray(i)).sizeD)
                        verticalReady = true;
                    end
                    while ~collision && ~verticalReady
                        departments(deptIndex).centroidY = departments(deptIndex).centroidY + 1;
                        [dist, collision] = detectCollision(departments(deptIndex), dir(2), [departments(deptIndex).sizeU, departments(deptIndex).sizeD+1, departments(deptIndex).sizeR, departments(deptIndex).sizeL], departments, matrixDim);
                        if collision && dist - departments(deptIndex).sizeD <= 1 && dist - departments(deptIndex).sizeD > 0
                            departments(deptIndex).centroidY = departments(deptIndex).centroidY + dist - departments(deptIndex).sizeD;
                            [dist, collision] = detectCollision(departments(deptIndex), dir(2), [departments(deptIndex).sizeU, departments(deptIndex).sizeD+1, departments(deptIndex).sizeR, departments(deptIndex).sizeL], departments, matrixDim);
                        end
                        if dist - departments(deptIndex).sizeD == 0 || (horizontalReady && departments(deptIndex).centroidY - departments(deptIndex).sizeU >= departments(costArray(i)).centroidY - departments(costArray(i)).sizeU && departments(deptIndex).centroidY + departments(deptIndex).sizeD <= departments(costArray(i)).centroidY + departments(costArray(i)).sizeD)
                            verticalReady = true;
                        end
                    end                    
                else
                    [dist, collision] = detectCollision(departments(deptIndex), dir(1), [departments(deptIndex).sizeU+1, departments(deptIndex).sizeD, departments(deptIndex).sizeR, departments(deptIndex).sizeL], departments, matrixDim);
                    if collision && dist - departments(deptIndex).sizeU <= 1 && dist - departments(deptIndex).sizeU > 0
                        departments(deptIndex).centroidY = departments(deptIndex).centroidY - dist + departments(deptIndex).sizeU;
                        [dist, collision] = detectCollision(departments(deptIndex), dir(1), [departments(deptIndex).sizeU+1, departments(deptIndex).sizeD, departments(deptIndex).sizeR, departments(deptIndex).sizeL], departments, matrixDim);
                    end
                    if dist - departments(deptIndex).sizeU == 0 || (horizontalReady && departments(deptIndex).centroidY - departments(deptIndex).sizeU >= departments(costArray(i)).centroidY - departments(costArray(i)).sizeU && departments(deptIndex).centroidY + departments(deptIndex).sizeD <= departments(costArray(i)).centroidY + departments(costArray(i)).sizeD)
                        verticalReady = true;
                    end
                    while ~collision && ~verticalReady
                        departments(deptIndex).centroidY = departments(deptIndex).centroidY - 1;
                        [dist, collision] = detectCollision(departments(deptIndex), dir(1), [departments(deptIndex).sizeU+1, departments(deptIndex).sizeD, departments(deptIndex).sizeR, departments(deptIndex).sizeL], departments, matrixDim);
                        if collision && dist - departments(deptIndex).sizeU <= 1 && dist - departments(deptIndex).sizeU > 0
                            departments(deptIndex).centroidY = departments(deptIndex).centroidY - dist + departments(deptIndex).sizeU;
                            [dist, collision] = detectCollision(departments(deptIndex), dir(1), [departments(deptIndex).sizeU+1, departments(deptIndex).sizeD, departments(deptIndex).sizeR, departments(deptIndex).sizeL], departments, matrixDim);
                        end
                        if dist - departments(deptIndex).sizeU == 0 || (horizontalReady && departments(deptIndex).centroidY - departments(deptIndex).sizeU >= departments(costArray(i)).centroidY - departments(costArray(i)).sizeU && departments(deptIndex).centroidY + departments(deptIndex).sizeD <= departments(costArray(i)).centroidY + departments(costArray(i)).sizeD)
                            verticalReady = true;
                        end
                    end  
                end
                
            else
                deptIndex = deptIndex + 1;
                horizontalReady = false;
                verticalReady = false;
            end
        
        end
        
        if horizontalReady && verticalReady
            deptIndex = deptIndex + 1;
            horizontalReady = false;
            verticalReady = false;
        end
        
        if deptIndex > length(departments)
            break;
        end
    end

end
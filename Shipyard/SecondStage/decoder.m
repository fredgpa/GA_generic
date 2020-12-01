function [department] = decoder(ind, problem)

    matrixDim = problem.matrixDim;
    depCentroid = problem.initialCentroids;
    depSize = problem.depSize;
    n_ind = problem.n_ind;
    reqArea = problem.reqArea;
    reqAspect = problem.reqAspect;
    fixedPos = problem.fixedDept;
    
    department(n_ind) = Department;

    for i=1:n_ind
        
        department(i).n = i;
        department(i).centroidX = depCentroid(i, 1);
        department(i).centroidY = depCentroid(i, 2);
        department(i).reqArea = reqArea(i);
        department(i).reqAspect = reqAspect(i);
                
    end

    [~, sorted] = sort(ind);
    
    for i=1:n_ind
        
        texto = "DeptA:"
        sorted(i)
        
        
        depWidth = depSize(sorted(i), 1);
        depHeight = depSize(sorted(i), 2);
        
        yUpEnd = department(sorted(i)).centroidY - depHeight/2;
        yDownEnd = department(sorted(i)).centroidY + depHeight/2;
        xRightEnd = department(sorted(i)).centroidX + depWidth/2;
        xLeftEnd = department(sorted(i)).centroidX - depWidth/2;
        
        collision = [0 0];
        horizontalLength = [];
        verticalLength = [];
        
        for j=1:n_ind
            texto = "Dept B:"
            sorted(j)
            
            if yUpEnd >= 0
                if department(sorted(j)).centroidX + department(sorted(j)).sizeR >= xLeftEnd && department(sorted(j)).centroidX - department(sorted(j)).sizeL <= xRightEnd
                    if department(sorted(j)).centroidY + department(sorted(j)).sizeD > yUpEnd && department(sorted(j)).centroidY < department(sorted(i)).centroidY
                        collision(1) = 1;
                        if isempty(verticalLength) || abs(department(sorted(j)).centroidY - department(sorted(j)).sizeD - department(sorted(i)).centroidY) < verticalLength
                            verticalLength = abs(department(sorted(j)).centroidY - department(sorted(j)).sizeD - department(sorted(i)).centroidY);
                        end
                        continue;
                    end
                end
            else
                collision(1) = 1;
                if isempty(verticalLength) ||abs(department(sorted(i)).centroidY - 0) < verticalLength
                    verticalLength = abs(department(sorted(i)).centroidY - 0);
                end
                continue;
            end
            
            if yDownEnd <= matrixDim(2)
                if department(sorted(j)).centroidX + department(sorted(j)).sizeR >= xLeftEnd && department(sorted(j)).centroidX - department(sorted(j)).sizeL <= xRightEnd
                    if department(sorted(j)).centroidY - department(sorted(j)).sizeU < yDownEnd && department(sorted(j)).centroidY > department(sorted(i)).centroidY
                        collision(1) = 1;
                        if isempty(verticalLength) ||abs(department(sorted(j)).centroidY + department(sorted(j)).sizeU - department(sorted(i)).centroidY) < verticalLength
                            verticalLength = abs(department(sorted(j)).centroidY + department(sorted(j)).sizeU - department(sorted(i)).centroidY);
                        end
                        continue;
                    end
                end
            else
                collision(1) = 1;
                if isempty(verticalLength) ||abs(department(sorted(i)).centroidY - matrixDim(2)) < verticalLength
                    verticalLength = abs(department(sorted(i)).centroidY - matrixDim(2));
                end
                continue;
            end
            
            if xRightEnd <= matrixDim(1)
                if department(sorted(j)).centroidY + department(sorted(j)).sizeD >= yUpEnd && department(sorted(j)).centroidY - department(sorted(j)).sizeU <= yDownEnd
                    if department(sorted(j)).centroidX - department(sorted(j)).sizeL < xRightEnd && department(sorted(j)).centroidX > department(sorted(i)).centroidX
                        collision(2) = 1;
                        if isempty(horizontalLength) || abs(department(sorted(j)).centroidX + department(sorted(j)).sizeR - department(sorted(i)).centroidX) < horizontalLength
                            horizontalLength = abs(department(sorted(j)).centroidX - department(sorted(j)).sizeL - department(sorted(i)).centroidX);
                        end
                        continue;
                    end
                end
            else
                collision(2) = 1;
                if isempty(horizontalLength) || abs(department(sorted(i)).centroidX - matrixDim(1)) < horizontalLength
                    horizontalLength = abs(department(sorted(i)).centroidX - matrixDim(1));
                end
                continue;
            end
            
            if xLeftEnd >= 0
                if department(sorted(j)).centroidY + department(sorted(j)).sizeD >= yUpEnd && department(sorted(j)).centroidY - department(sorted(j)).sizeU <= yDownEnd
                    if department(sorted(j)).centroidX + department(sorted(j)).sizeR > xLeftEnd && department(sorted(j)).centroidX < department(sorted(i)).centroidX
                        collision(2) = 1;
                        if isempty(horizontalLength) || abs(department(sorted(j)).centroidX - department(sorted(j)).sizeL - department(sorted(i)).centroidX) < horizontalLength
                            horizontalLength = abs(department(sorted(j)).centroidX + department(sorted(j)).sizeR - department(sorted(i)).centroidX);
                        end
                        continue;
                    end
                end
            else
                collision(2) = 1;
                if isempty(horizontalLength) || abs(department(sorted(i)).centroidX - 0) < horizontalLength
                    horizontalLength = abs(department(sorted(i)).centroidX - 0);
                end
                continue;
            end
        end
        
        if collision(1) == 0
            department(sorted(i)).sizeU = depHeight/2;
            department(sorted(i)).sizeD = depHeight/2;
        else
            department(sorted(i)).sizeU = verticalLength;
            department(sorted(i)).sizeD = verticalLength;
        end
        
        if collision(2) == 0
            department(sorted(i)).sizeR = depWidth/2;
            department(sorted(i)).sizeL = depWidth/2;
        else
            department(sorted(i)).sizeR = horizontalLength;
            department(sorted(i)).sizeL = horizontalLength;
        end
        
        visual_representation(department, problem.matrixDim);
    end
end
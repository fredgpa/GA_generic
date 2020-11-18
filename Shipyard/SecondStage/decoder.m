function [department] = decoder(ind, problem)

    matrixDim = problem.matrixDim;
    depCentroid = problem.initialCentroids;
    depSize = problem.depSize;
    n_ind = problem.n_ind;
    
    department(n_ind) = Department;

    for i=1:n_ind
        
        department(i).n = i;
        department(i).centroidX = depCentroid(i, 1);
        department(i).centroidY = depCentroid(i, 2);
                
    end

    [~, sorted] = sort(ind);
    
    for i=1:n_ind
        
        
        depWidth = depSize(sorted(i), 1);
        depHeight = depSize(sorted(i), 2);
        
        yUpEnd = department(sorted(i)).centroidY + depHeight/2;
        yDownEnd = department(sorted(i)).centroidY - depHeight/2;
        xRightEnd = department(sorted(i)).centroidX + depWidth/2;
        xLeftEnd = department(sorted(i)).centroidX - depWidth/2;
        
        collision = [0 0 0 0];
        
        for j=1:i
            
            if yUpEnd > 0                
                if department(sorted(j)).centroidX + department(sorted(j)).sizeR >= xLeftEnd && department(sorted(j)).centroidX - department(sorted(j)).sizeL <= xRightEnd
                    if department(sorted(j)).centroidY - department(sorted(j)).sizeD > yUpEnd && department(sorted(j)).centroidY < department(sorted(i)).centroidY
                        collision(1) = 1;
                        upLength = abs(department(sorted(j)).centroidY - department(sorted(j)).sizeD - department(sorted(i)).centroidY);
                    end
                end
            end
            
            if yDownEnd < matrixDim(2)
                if department(sorted(j)).centroidX + department(sorted(j)).sizeR >= xLeftEnd && department(sorted(j)).centroidX - department(sorted(j)).sizeL <= xRightEnd
                    if department(sorted(j)).centroidY + department(sorted(j)).sizeU < yDownEnd && department(sorted(j)).centroidY > department(sorted(i)).centroidY
                        collision(2) = 1;
                        downLength = abs(department(sorted(j)).centroidY + department(sorted(j)).sizeU - department(sorted(i)).centroidY);
                    end
                end
            end
            
            if xRightEnd < matrixDim(1)
                if department(sorted(j)).centroidY + department(sorted(j)).sizeD >= yUpEnd && department(sorted(j)).centroidY - department(sorted(j)).sizeU <= yDownEnd
                    if department(sorted(j)).centroidX - department(sorted(j)).sizeL < xRightEnd && department(sorted(j)).centroidX > department(sorted(i)).centroidX
                        collision(1) = 1;
                        rightLength = abs(department(sorted(j)).centroidX + department(sorted(j)).sizeR - department(sorted(i)).centroidX);
                    end
                end
            end
            
            if xLeftEnd > 0
                if department(sorted(j)).centroidY + department(sorted(j)).sizeD >= yUpEnd && department(sorted(j)).centroidY - department(sorted(j)).sizeU <= yDownEnd
                    if department(sorted(j)).centroidX + department(sorted(j)).sizeR > xLeftEnd && department(sorted(j)).centroidX < department(sorted(i)).centroidX
                        collision(1) = 1;
                        downLength = abs(department(sorted(j)).centroidX - department(sorted(j)).sizeL - department(sorted(i)).centroidX);
                    end
                end
            end
        end
        
        if collision(1) == 0            
            department(sorted(i)).sizeU = depHeight/2;
        else
            department(sorted(i)).sizeU = upLength;
        end
        
        if collision(2) == 0
            department(sorted(i)).sizeD = depHeight/2;
        else
            department(sorted(i)).sizeD = downLength;
        end
        
        if collision(3) == 0
            department(sorted(i)).sizeR = depWidth/2;
        else
            department(sorted(i)).sizeR = rightLength;
        end
        
        if collision(4) == 0
            department(sorted(i)).sizeL = depWidth/2;
        else
            department(sorted(i)).sizeL = leftLength;
        end
    end
    
    visual_representation(department);
end
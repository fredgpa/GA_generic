function [department] = decoder(ind, problem)

    matrixDim = problem.matrixDim;
    depCentroid = problem.initialCentroids;
    depSize = problem.depSize;
    n_indSize = problem.n_indSize;
    reqArea = problem.reqArea;
    reqAspect = problem.reqAspect;
    fixedDept = problem.fixedDept;
    
    department(n_indSize) = Department;
    
    [~, sorted] = sort(ind);

    for i=1:n_indSize
        
        department(i).n = i;
        department(i).centroidX = depCentroid(i, 1);
        department(i).centroidY = depCentroid(i, 2);
        department(i).reqArea = reqArea(i);
        department(i).reqAspect = reqAspect(i);
        
        if ismember(i, fixedDept)
            department(i).sizeR = depSize(i, 1)/2;
            department(i).sizeL = depSize(i, 1)/2;
            department(i).sizeU = depSize(i, 2)/2;
            department(i).sizeD = depSize(i, 2)/2;
        end
    end

    
    %%visual_representation(department, problem.matrixDim);
    
    for i=1:n_indSize
        if ~ismember(sorted(i), fixedDept)
            %texto = "DeptA:"
            %sorted(i)


            depWidth = depSize(sorted(i), 1);
            depHeight = depSize(sorted(i), 2);
            
            collision = [false false false false];
            [upLength, collision(1)] = detectCollision(department(sorted(i)), "up", [depHeight/2, depHeight/2, depWidth/2, depWidth/2], department, matrixDim);
            [downLength, collision(2)] = detectCollision(department(sorted(i)), "down", [depHeight/2, depHeight/2, depWidth/2, depWidth/2], department, matrixDim);
            [rightLength, collision(3)] = detectCollision(department(sorted(i)), "right", [depHeight/2, depHeight/2, depWidth/2, depWidth/2], department, matrixDim);
            [leftLength, collision(4)] = detectCollision(department(sorted(i)), "left", [depHeight/2, depHeight/2, depWidth/2, depWidth/2], department, matrixDim);
            

            if collision(1) == collision(2)
                department(sorted(i)).sizeU = upLength;
                department(sorted(i)).sizeD = downLength;

                department(sorted(i)) = department(sorted(i)).center;
            elseif collision(1)
                department(sorted(i)).sizeU = upLength;
                department(sorted(i)).sizeD = detectCollision(department(sorted(i)), "down", [upLength, depHeight - upLength, depWidth/2, depWidth/2], department, matrixDim);
                    
                department(sorted(i)) = department(sorted(i)).center;
            else
                department(sorted(i)).sizeD = downLength;
                department(sorted(i)).sizeU = detectCollision(department(sorted(i)), "up", [depHeight - downLength, downLength, depWidth/2, depWidth/2], department, matrixDim);

                department(sorted(i)) = department(sorted(i)).center;
            end


            if collision(3) == collision(4)
                department(sorted(i)).sizeR = rightLength;
                department(sorted(i)).sizeL = leftLength;

                department(sorted(i)) = department(sorted(i)).center;
            elseif collision(3)
                department(sorted(i)).sizeR = rightLength;
                department(sorted(i)).sizeL = detectCollision(department(sorted(i)), "left", [depHeight/2, depHeight/2, rightLength, depHeight - rightLength], department, matrixDim);

                department(sorted(i)) = department(sorted(i)).center;
            else
                department(sorted(i)).sizeL = leftLength;
                department(sorted(i)).sizeR = detectCollision(department(sorted(i)), "right", [depHeight/2, depHeight/2, depHeight - leftLength, leftLength], department, matrixDim);

                department(sorted(i)) = department(sorted(i)).center;
            end

            
        end
    end
    
   %%visual_representation(department, problem.matrixDim); 
end
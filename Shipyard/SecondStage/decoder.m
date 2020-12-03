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

            yUpEnd = department(sorted(i)).centroidY - depHeight/2;
            yDownEnd = department(sorted(i)).centroidY + depHeight/2;
            xRightEnd = department(sorted(i)).centroidX + depWidth/2;
            xLeftEnd = department(sorted(i)).centroidX - depWidth/2;

            collision = [0 0 0 0];
            rightLength = [];
            leftLength = [];
            upLength = [];
            downLength = [];

            for j=1:n_indSize
                %texto = "Dept B:"
                %sorted(j)

                if yUpEnd >= 0
                    if department(sorted(j)).centroidX + department(sorted(j)).sizeR >= xLeftEnd && department(sorted(j)).centroidX - department(sorted(j)).sizeL <= xRightEnd
                        if department(sorted(j)).centroidY + department(sorted(j)).sizeD > yUpEnd && department(sorted(j)).centroidY < department(sorted(i)).centroidY
                            collision(1) = 1;
                            if isempty(upLength) || abs(department(sorted(j)).centroidY + department(sorted(j)).sizeD - department(sorted(i)).centroidY) < upLength
                                upLength = abs(department(sorted(j)).centroidY + department(sorted(j)).sizeD - department(sorted(i)).centroidY);
                            end
                            continue;
                        end
                    end
                else
                    collision(1) = 1;
                    if isempty(upLength) ||abs(department(sorted(i)).centroidY - 0) < upLength
                        upLength = abs(department(sorted(i)).centroidY - 0);
                    end
                    continue;
                end

                if yDownEnd <= matrixDim(2)
                    if department(sorted(j)).centroidX + department(sorted(j)).sizeR >= xLeftEnd && department(sorted(j)).centroidX - department(sorted(j)).sizeL <= xRightEnd
                        if department(sorted(j)).centroidY - department(sorted(j)).sizeU < yDownEnd && department(sorted(j)).centroidY > department(sorted(i)).centroidY
                            collision(2) = 1;
                            if isempty(downLength) ||abs(department(sorted(j)).centroidY - department(sorted(j)).sizeU - department(sorted(i)).centroidY) < downLength
                                downLength = abs(department(sorted(j)).centroidY - department(sorted(j)).sizeU - department(sorted(i)).centroidY);
                            end
                            continue;
                        end
                    end
                else
                    collision(2) = 1;
                    if isempty(downLength) ||abs(department(sorted(i)).centroidY - matrixDim(2)) < downLength
                        downLength = abs(department(sorted(i)).centroidY - matrixDim(2));
                    end
                    continue;
                end

                if xRightEnd <= matrixDim(1)
                    if department(sorted(j)).centroidY + department(sorted(j)).sizeD >= yUpEnd && department(sorted(j)).centroidY - department(sorted(j)).sizeU <= yDownEnd
                        if department(sorted(j)).centroidX - department(sorted(j)).sizeL < xRightEnd && department(sorted(j)).centroidX > department(sorted(i)).centroidX
                            collision(3) = 1;
                            if isempty(rightLength) || abs(department(sorted(j)).centroidX + department(sorted(j)).sizeR - department(sorted(i)).centroidX) < rightLength
                                rightLength = abs(department(sorted(j)).centroidX - department(sorted(j)).sizeL - department(sorted(i)).centroidX);
                            end
                            continue;
                        end
                    end
                else
                    collision(3) = 1;
                    if isempty(rightLength) || abs(department(sorted(i)).centroidX - matrixDim(1)) < rightLength
                        rightLength = abs(department(sorted(i)).centroidX - matrixDim(1));
                    end
                    continue;
                end

                if xLeftEnd >= 0
                    if department(sorted(j)).centroidY + department(sorted(j)).sizeD >= yUpEnd && department(sorted(j)).centroidY - department(sorted(j)).sizeU <= yDownEnd
                        if department(sorted(j)).centroidX + department(sorted(j)).sizeR > xLeftEnd && department(sorted(j)).centroidX < department(sorted(i)).centroidX
                            collision(4) = 1;
                            if isempty(leftLength) || abs(department(sorted(j)).centroidX - department(sorted(j)).sizeL - department(sorted(i)).centroidX) < leftLength
                                leftLength = abs(department(sorted(j)).centroidX + department(sorted(j)).sizeR - department(sorted(i)).centroidX);
                            end
                            continue;
                        end
                    end
                else
                    collision(4) = 1;
                    if isempty(leftLength) || abs(department(sorted(i)).centroidX - 0) < leftLength
                        leftLength = abs(department(sorted(i)).centroidX - 0);
                    end
                    continue;
                end
            end

            if collision(1) == 0 && collision(2) == 0
                department(sorted(i)).sizeU = depHeight/2;
                department(sorted(i)).sizeD = depHeight/2;
            else
                if collision(1) == 1 && collision(2) == 1
                    department(sorted(i)).sizeU = upLength;
                    department(sorted(i)).sizeD = downLength;
                    
                    department(sorted(i)) = department(sorted(i)).center;
                elseif collision(1) == 1
                    department(sorted(i)).sizeU = upLength;
                    department(sorted(i)).sizeD = depHeight - upLength;
                    
                    department(sorted(i)) = department(sorted(i)).center;
                else
                    department(sorted(i)).sizeD = downLength;
                    department(sorted(i)).sizeU = depHeight - downLength;
                    
                    department(sorted(i)) = department(sorted(i)).center;
                end
            end

            if collision(3) == 0 && collision(4) == 0
                department(sorted(i)).sizeR = depWidth/2;
                department(sorted(i)).sizeL = depWidth/2;
            else
                if collision(3) == 1 && collision(4) == 1
                    department(sorted(i)).sizeR = rightLength;
                    department(sorted(i)).sizeL = leftLength;
                    
                    department(sorted(i)) = department(sorted(i)).center;
                elseif collision(3) == 1
                    department(sorted(i)).sizeR = rightLength;
                    department(sorted(i)).sizeL = depHeight - rightLength;
                    
                    department(sorted(i)) = department(sorted(i)).center;
                else
                    department(sorted(i)).sizeL = leftLength;
                    department(sorted(i)).sizeR = depHeight - leftLength;
                    
                    department(sorted(i)) = department(sorted(i)).center;
                end
            end

            %%visual_representation(department, problem.matrixDim);
        end
    end
end
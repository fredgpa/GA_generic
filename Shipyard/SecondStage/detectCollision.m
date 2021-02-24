function [newDist, bool] = detectCollision(depA, dir, dist, department, matrixDim)
    newDist = [];
    bool = false;
    
        
        if dir == "up"
            
            for i=1:length(department)
                depB = department(i);

                %texto = "Dept B:"
                %depB.n
                
                yUpEnd = depA.centroidY - dist(1);
                if yUpEnd >= 0
                    if depB.centroidX + depB.sizeR > depA.centroidX - dist(4) && depB.centroidX - depB.sizeL <  depA.centroidX + dist(3) && depB.centroidY + depB.sizeD <= depA.centroidY - depA.sizeU
                        if depB.centroidY + depB.sizeD >= yUpEnd
                            if isempty(newDist) || abs(depB.centroidY + depB.sizeD - depA.centroidY) < newDist
                                newDist = abs(depB.centroidY + depB.sizeD - depA.centroidY);
                                bool = true;
                                continue;
                            end
                        end
                    end
                else
                    if isempty(newDist) || abs(depB.centroidY + depB.sizeD - depA.centroidY) < newDist
                        newDist = abs(0 - depA.centroidY);
                        bool = true;
                        continue;
                    end
                end
            end
            
            if isempty(newDist)
                newDist = dist(1);
            end
        elseif dir == "down" 
            for i=1:length(department)
                depB = department(i);

                %texto = "Dept B:"
                %depB.n
                
                yDownEnd = depA.centroidY + dist(2);
                if yDownEnd <= matrixDim(2)
                    if depB.centroidX + depB.sizeR > depA.centroidX - dist(4) && depB.centroidX - depB.sizeL < depA.centroidX + dist(3) && depB.centroidY - depB.sizeU >= depA.centroidY + depA.sizeD
                        if depB.centroidY - depB.sizeU <= yDownEnd                       
                            if isempty(newDist) ||abs(depB.centroidY - depB.sizeU - depA.centroidY) < newDist
                                newDist = abs(depB.centroidY - depB.sizeU - depA.centroidY);
                                bool = true;
                                continue;
                            end   
                        end
                    end
                else
                    if isempty(newDist) ||abs(depB.centroidY - depB.sizeU - depA.centroidY) < newDist
                        newDist = abs(matrixDim(2) - depA.centroidY);
                        bool = true;
                        continue;
                    end
                end
            end
            
            if isempty(newDist)
                newDist = dist(2);
            end
        elseif dir == "right"
            for i=1:length(department)
                depB = department(i);

                %texto = "Dept B:"
                %depB.n
                
                xRightEnd = depA.centroidX + dist(3);
                if xRightEnd <= matrixDim(1)
                    if depB.centroidY + depB.sizeD > depA.centroidY - dist(1) && depB.centroidY - depB.sizeU <  depA.centroidY + dist(2) && depB.centroidX - depB.sizeL >= depA.centroidX + depA.sizeR
                        if depB.centroidX - depB.sizeL <= xRightEnd
                            if isempty(newDist) || abs(depB.centroidX - depB.sizeL - depA.centroidX) < newDist
                                newDist = abs(depB.centroidX - depB.sizeL - depA.centroidX);
                                bool = true;
                                continue;
                            end
                        end
                    end
                else
                    if isempty(newDist) || abs(depB.centroidX - depB.sizeL - depA.centroidX) < newDist
                        newDist = abs(matrixDim(1) - depA.centroidX);
                        bool = true;
                        continue;
                    end
                end
            end
            
            if isempty(newDist)
                newDist = dist(3);
            end
        else
            for i=1:length(department)
                depB = department(i);

                %texto = "Dept B:"
                %depB.n
                
                xLeftEnd = depA.centroidX - dist(4);
                if xLeftEnd >= 0
                    if depB.centroidY + depB.sizeD > depA.centroidY - dist(1) && depB.centroidY - depB.sizeU < depA.centroidY + dist(2) && depB.centroidX + depB.sizeR <= depA.centroidX - depA.sizeL
                        if depB.centroidX + depB.sizeR >= xLeftEnd && depB.centroidX < depA.centroidX
                            if isempty(newDist) || abs(depB.centroidX + depB.sizeR - depA.centroidX) < newDist
                                newDist = abs(depB.centroidX + depB.sizeR - depA.centroidX);
                                bool = true;
                                continue;
                            end
                        end
                    end
                else
                    if isempty(newDist) || abs(depB.centroidX + depB.sizeR - depA.centroidX) < newDist
                        newDist = abs(0 - depA.centroidX);
                        bool = true;
                        continue;
                    end
                end
            end
            
            if isempty(newDist)
                newDist = dist(4);
            end
        end

end
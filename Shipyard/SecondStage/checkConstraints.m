function [bool, ind, constraintsProblem] = checkConstraints(ind, constraintsProblem)

    load('Shipyard\constraint_table.mat');
    
    for i=1:length(constraints)
        
        for j=1:length(ind)           
            if ind(j).n == constraints(i, 1)
                deptA = ind(j);
            elseif ind(j).n == constraints(i, 2)
                deptB = ind(j);
            end
        end
        
        distCentroid_X = abs(deptA.centroidX - deptB.centroidX);
        distCentroid_Y = abs(deptA.centroidY - deptB.centroidY);
        
        if constraints(i, 3)
            if distCentroid_X == (deptA.sizeR + deptB.sizeR) && (deptA.centroidX > deptB.centroidX + deptB.sizeR  || deptA.centroidX < deptB.centroidX - deptB.sizeL)
                constraintsProblem(i).achAdj = 1;
            elseif distCentroid_Y == (deptA.sizeU + deptB.sizeU) && (deptA.centroidY > deptB.centroidY + deptB.sizeD  || deptA.centroidY < deptB.centroidY - deptB.sizeU)
                constraintsProblem(i).achAdj = 1;
            else
                constraintsProblem(i).achAdj = 0;
            end
        else
            constraintsProblem(i).achAdj = 0;
        end
        
        if constraints(i, 4)
            if 2*deptA.sizeU == 2*deptB.sizeU && deptA.centroidY == deptB.centroidY
                constraintsProblem(i).achAlign = 1;
            elseif 2*deptA.sizeR == 2*deptB.sizeR && deptA.centroidX == deptB.centroidX
                constraintsProblem(i).achAlign = 1;
            else
                constraintsProblem(i).achAlign = 0;
            end
        else
            constraintsProblem(i).achAlign = 0;
        end
        
    end

    bool = true;
end
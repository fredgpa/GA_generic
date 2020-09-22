classdef Constraint
    properties 
        deptA = [];
        deptB = [];
        reqAlign = [];
        reqAdj = [];
        achAlign = [];
        achAdj = [];
    end
    methods
        function obj = constraintCheck(obj, deptA, deptB)
            %deptA = deptA.center;
            %deptB = deptB.center;
            distX_Y = sqrt((deptA.centroidX - deptB.centroidX)^2 + (deptA.centroidY - deptB.centroidY)^2);
            
            if (deptA.centroidY >= deptB.centroidY) && length(intersect([(deptA.centroidX - deptA.sizeL):(deptA.centroidX + deptA.sizeR)], [(deptB.centroidX - deptB.sizeL):(deptB.centroidX + deptB.sizeR)])) > max(min((deptA.sizeR + deptA.sizeL)/2, (deptB.sizeR + deptB.sizeL)/2),1) %#ok<*NBRAK>
                %up
                if abs(deptA.centroidY - deptB.centroidY) == (deptA.sizeU + deptB.sizeD)
                    obj.achAdj = true;
                    if deptA.centroidX + deptA.sizeR == deptB.centroidX + deptB.sizeR && deptA.centroidX - deptA.sizeL == deptB.centroidX - deptB.sizeL
                        obj.achAlign = true;
                    else
                        obj.achAlign = false;
                    end
                elseif deptA.centroidX == deptB.centroidX && ~obj.reqAdj
                    obj.achAdj = false;
                    obj.achAlign = true;  
                else
                    obj.achAdj = false;
                    obj.achAlign = false;  
                end
            elseif (deptA.centroidX <= deptB.centroidX) && length(intersect([(deptA.centroidY - deptA.sizeU):(deptA.centroidY + deptA.sizeD)], [(deptB.centroidY - deptB.sizeU):(deptB.centroidY + deptB.sizeD)])) > max(min((deptA.sizeU + deptA.sizeD)/2, (deptB.sizeU + deptB.sizeD)/2),1)
                %right
                if abs(deptA.centroidX - deptB.centroidX) == (deptA.sizeR + deptB.sizeL)
                    obj.achAdj = true;
                    if deptA.centroidY + deptA.sizeD == deptB.centroidY + deptB.sizeD && deptA.centroidY - deptA.sizeU == deptB.centroidY - deptB.sizeU
                        obj.achAlign = true;
                    else
                        obj.achAlign = false;
                    end
                elseif deptA.centroidY == deptB.centroidY && ~obj.reqAdj
                    obj.achAdj = false;
                    obj.achAlign = true;  
                else
                    obj.achAdj = false;
                    obj.achAlign = false;  
                end
            elseif (deptA.centroidY <= deptB.centroidY) && length(intersect([(deptA.centroidX - deptA.sizeL):(deptA.centroidX + deptA.sizeR)], [(deptB.centroidX - deptB.sizeL):(deptB.centroidX + deptB.sizeR)])) > max(min((deptA.sizeR + deptA.sizeL)/2, (deptB.sizeR + deptB.sizeL)/2),1)
                %down
                if abs(deptA.centroidY - deptB.centroidY) == (deptA.sizeD + deptB.sizeU)
                    obj.achAdj = true;
                    if deptA.centroidX + deptA.sizeR == deptB.centroidX + deptB.sizeR && deptA.centroidX - deptA.sizeL == deptB.centroidX - deptB.sizeL
                        obj.achAlign = true;
                    else
                        obj.achAlign = false;
                    end
                elseif deptA.centroidX == deptB.centroidX && ~obj.reqAdj
                    obj.achAdj = false;
                    obj.achAlign = true;  
                else
                    obj.achAdj = false;
                    obj.achAlign = false;                 
                end
            elseif (deptA.centroidX >= deptB.centroidX) && length(intersect([(deptA.centroidY - deptA.sizeU):(deptA.centroidY + deptA.sizeD)], [(deptB.centroidY - deptB.sizeU):(deptB.centroidY + deptB.sizeD)])) > max(min((deptA.sizeU + deptA.sizeD)/2, (deptB.sizeU + deptB.sizeD)/2), 1)
                %left
                if abs(deptA.centroidX - deptB.centroidX) == (deptA.sizeL + deptB.sizeR)
                    obj.achAdj = true;
                    if deptA.centroidY + deptA.sizeD == deptB.centroidY + deptB.sizeD && deptA.centroidY - deptA.sizeU == deptB.centroidY - deptB.sizeU
                        obj.achAlign = true;
                    else
                        obj.achAlign = false;
                    end
                elseif (deptA.centroidY == deptB.centroidY) && ~obj.reqAdj
                    obj.achAdj = false;
                    obj.achAlign = true;  
                else
                    obj.achAdj = false;
                    obj.achAlign = false;                   
                end
            else
                obj.achAdj = false;
                obj.achAlign = false;
            end
            
            if obj.reqAlign && ~obj.reqAdj
                if deptA.centroidX == deptB.centroidX || deptA.centroidY == deptB.centroidY
                    obj.achAlign = true;
                end
            end
        end
        function bool = checkDept(obj, dept)
            if obj.deptA == dept || obj.deptB == dept
                bool = true;
            else
                bool = false;
            end
        end

    end
end
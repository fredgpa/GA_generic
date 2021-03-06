classdef Department
    properties
        n = [];
        centroidX = [];
        centroidY = [];
        sizeU = .5;
        sizeD = .5;
        sizeR = .5;
        sizeL = .5;
        reqArea = [];
        reqAspect = [];
        fixedPos = [];
        fixedSize = [];
        fixedAspect = false;
        directions = [];
        flowPoint = [];
        flowDirections = [];
        horizontal = [];
    end
    methods
        function obj = updateDir(obj)
            if ~obj.fixedAspect
                if (obj.sizeL + obj.sizeR) < (obj.sizeU + obj.sizeD)
                    obj.directions = ["up" "down" "right" "left"];
                else
                    obj.directions = ["left" "right" "up" "down"];
                end
            end
        end
        function result = calcAspect(obj)
            if (obj.sizeL + obj.sizeR) > (obj.sizeU + obj.sizeD)
                result = (obj.sizeL + obj.sizeR)/(obj.sizeU + obj.sizeD);
            else
                result = (obj.sizeU + obj.sizeD)/(obj.sizeL + obj.sizeR);
            end
        end
        function result = calcArea(obj)
            result = (obj.sizeU + obj.sizeD) * (obj.sizeL + obj.sizeR);
        end
        function obj = grow(obj, dir)
            if dir == "up"
                obj.sizeU = obj.sizeU + 1;
            elseif dir == "right"
                obj.sizeR = obj.sizeR + 1;
            elseif dir == "down"
                obj.sizeD = obj.sizeD + 1;
            else
                obj.sizeL = obj.sizeL + 1;
            end
        end
        function obj = shrink(obj, dir)
            if dir == "up" && obj.sizeU > 0
                obj.sizeU = obj.sizeU - 1;
            elseif dir == "right" && obj.sizeR > 0
                obj.sizeR = obj.sizeR - 1;
            elseif dir == "down" && obj.sizeD > 0
                obj.sizeD = obj.sizeD - 1;
            elseif obj.sizeL > 0
                obj.sizeL = obj.sizeL - 1;
            end
        end
        function obj = move(obj, dir)
            if dir == "up"
                obj.centroidY = obj.centroidY - 1;
            elseif dir == "right"
                obj.centroidX = obj.centroidX + 1;
            elseif dir == "down"
                obj.centroidY = obj.centroidY + 1;
            else
                obj.centroidX = obj.centroidX - 1;
            end
        end
        function obj = center(obj)
            obj.centroidX = ((obj.centroidX - obj.sizeL) + (obj.centroidX + obj.sizeR))/2;
            obj.centroidY = ((obj.centroidY - obj.sizeU) + (obj.centroidY + obj.sizeD))/2;

            wid = obj.sizeL + obj.sizeR;
            hei = obj.sizeU + obj.sizeD;

            obj.sizeL = wid/2;
            obj.sizeR = wid/2;

            obj.sizeU = hei/2;
            obj.sizeD = hei/2;
        end
        function direction = dirRelation(obj, dept)
            if obj.centroidX == dept.centroidX
                if obj.centroidY > dept.centroidY
                    direction = "up";
                else
                    direction = "down";
                end
            elseif obj.centroidY == dept.centroidY
                if obj.centroidX > dept.centroidX
                    direction = "left";
                else
                    direction = "right";
                end
            elseif obj.centroidX > dept.centroidX
                if abs(obj.centroidX - dept.centroidX) < (obj.sizeL + dept.sizeR)
                    if obj.centroidY > dept.centroidY
                        direction = "up";
                    else
                        direction = "down";
                    end
                else
                    direction = "left";
                end
            elseif obj.centroidX < dept.centroidX
                if abs(obj.centroidX - dept.centroidX) < (obj.sizeR + dept.sizeL)
                    if obj.centroidY > dept.centroidY
                        direction = "up";
                    else
                        direction = "down";
                    end
                else
                    direction = "right";
                end
            elseif obj.centroidY > dept.centroidY
                if abs(obj.centroidY - dept.centroidY) < (obj.sizeU + dept.sizeD)
                    if obj.centroidX > dept.centroidX
                        direction = "left";
                    else
                        direction = "right";
                    end
                else
                    direction = "up";
                end
            elseif obj.centroidY < dept.centroidY
                if abs(obj.centroidY - dept.centroidY) < (obj.sizeD + dept.sizeU)
                    if obj.centroidX > dept.centroidX
                        direction = "left";
                    else
                        direction = "right";
                    end
                else
                    direction = "down";
                end
            end
        end
        function obj = updateFlowPoint(obj)
            obj.flowPoint = [ obj.centroidX obj.centroidY ];
            if ~isempty(obj.flowDirections)
                if ismember("up", obj.flowDirections)
                    obj.flowPoint(2) = obj.flowPoint(2) - obj.sizeU;
                end
                if ismember("right", obj.flowDirections)
                    obj.flowPoint(1) = obj.flowPoint(1) + obj.sizeR;
                end
                if ismember("down", obj.flowDirections)
                    obj.flowPoint(2) = obj.flowPoint(2) + obj.sizeD;
                end
                if ismember("left", obj.flowDirections)
                    obj.flowPoint(1) = obj.flowPoint(1) - obj.sizeU;
                end               
            end
        end
        function result = checkSize(obj, dir)
            result = false;
            if dir == "up"
                if obj.sizeU > 1
                    result = true;
                end
            elseif dir == "down"
                if obj.sizeD > 1
                    result = true;
                end
            elseif dir == "left"
                if obj.sizeL > 1
                    result = true;
                end
            else
                if obj.sizeR > 1
                    result = true;
                end
            end
                
        end
    end
end
function [bool] = checkConstraints(ind,dim)

    load('Shipyard\constraint_table.mat');
    
    for i= 1:length(constraints)
        pos1 = find([ind(:)==constraints(i,1)]);
        pos2 = find([ind(:)==constraints(i,2)]);
        
        if constraints(i,4)
            if (((pos2 == pos1 + 1) || (pos2 == pos1 - 1)) && (ceil(pos1/dim(2)) == ceil(pos2/dim(2)))) || (pos2 == pos1 + dim(2)) || (pos2 == pos1 - dim(2))
                bool = true;
            else
                bool = false;
                break;
            end
        else
            if (((pos2 == pos1 + 1) || (pos2 == pos1 - 1)) && (ceil(pos1/dim(2)) == ceil(pos2/dim(2)))) || (pos2 == pos1 + dim(2)) || (pos2 == pos1 - dim(2)) || (pos2 == pos1 + dim(2) + 1) || (pos2 == pos1 + dim(2) - 1) || (pos2 == pos1 - dim(2) - 1) || (pos2 == pos1 - dim(2) + 1)
                bool = true;
            else
                bool = false;
                break;
            end
        end
    end

end
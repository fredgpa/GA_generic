function [sorted] = decoder(ind, problem)

    dim = problem.matrixDim;

    [~, sorted] = sort(ind);

    if problem.fixedDept
        load('Shipyard\fixedDep_table.mat');
        for i=1:length(fixedDepartments_table(:,1))
            sorted([sorted(:)] == fixedDepartments_table(i,1)) = [];
        end

        for i=1:length(fixedDepartments_table(:,1))
            index = (fixedDepartments_table(i,2)-1)*dim(2) + fixedDepartments_table(i,3);
            if index == 1
                sorted = [fixedDepartments_table(i,1) sorted];
            elseif index > length(sorted)
                sorted(index) = fixedDepartments_table(i,1);
            else
                if sorted(index) == 0
                    sorted(index) = fixedDepartments_table(i,1);
                else
                    sorted = [sorted(1:index-1) fixedDepartments_table(i,1) sorted(index:end)];
                end
            end
        end
    end


end
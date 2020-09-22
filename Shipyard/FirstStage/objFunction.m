function [fx] = objFunction(ind, dim)

    ord = decoder(ind);

    load('Shipyard\cost_table.mat');
    load('Shipyard\material_table.mat');
    
    size = length(ord);
    
    
    if checkConstraints(ord,dim)
        k=1;
        for i = 1:dim(1)
          for j = 1:dim(2)
            pos(i, j) = ord(k);
            k = k + 1;
          end
        end

        distance = zeros(size);
        for i = 1:dim(1)
            for j = 1:dim(2)
                for i2 = 1:dim(1)
                  for j2 = 1:dim(2)
                      if i ~= i2 || j ~= j2
                        distance(pos(i, j), pos(i2, j2)) = sqrt((i2-i)^2 + (j2-j)^2);
                      end
                  end
                end
            end
        end

        fx = 0;
        for i = 1:size
            for j = 1:size
              fx = fx + costs(i, j)*materials(i, j)*distance(i, j);
            end
        end
    else
        fx = Inf;
    end
    
end
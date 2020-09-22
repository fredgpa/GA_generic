function [result] = objFunction(ind)

    ord = decoder(ind);

    load('Shipyard\cost_table.mat');
    load('Shipyard\material_table.mat');
    
    result = 10*ord(1) + 9*(ord(2)) - 100*(ord(3)) + 5*(ord(4)-ord(5)) + 10*ord(6) + 9*(ord(7)) - 100*(ord(8)) + 5*(ord(9)-ord(10)) + 10*ord(11) + 9*(ord(12)) - 100*(ord(13)) + 5*(ord(14)-ord(15)) + 10*ord(16) + 9*(ord(17)) - 100*(ord(18)) + 5*(ord(19)-ord(20));

end
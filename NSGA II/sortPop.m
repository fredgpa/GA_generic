function [sortedPop] = sortPop(pop, new_order)

    rankA = 5;
    rankB = 20;
    rankC = 35;
    rankD = 40;


    begin = 1;
    final = rankA;
    interval = new_order(begin:final);
    sortedPop.rankA = pop(interval);
    
    begin = begin + rankA;
    final = begin + rankB - 1;
    interval = new_order(begin:final);
    sortedPop.rankB = pop(interval);
    
    begin = begin + rankB;
    final = begin + rankC - 1;
    interval = new_order(begin:final);
    sortedPop.rankC = pop(interval);
    
    begin = begin + rankC;
    final = begin + rankD - 1;
    interval = new_order(begin:final);
    sortedPop.rankD = pop(interval);
    
end
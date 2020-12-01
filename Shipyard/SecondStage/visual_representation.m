function [] = visual_representation(department, dim)
    
    figure;
    set(gca, 'YDir', 'reverse', 'XAxisLocation', 'Top');
    xlim([0, dim(1)]);
    ylim([0, dim(2)]);
    
    for i=1:length(department)
        rectangle('Position', [department(i).centroidX - department(i).sizeL, department(i).centroidY - department(i).sizeU, department(i).sizeL + department(i).sizeR, department(i).sizeU + department(i).sizeD], 'FaceColor', [rand() rand() rand()]);
        text((department(i).centroidX - department(i).sizeL + department(i).centroidX + department(i).sizeR)/2,(department(i).centroidY - department(i).sizeU + department(i).centroidY + department(i).sizeD)/2,num2str(i),'HorizontalAlignment','center')
    end
end


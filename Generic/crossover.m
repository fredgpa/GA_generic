function [child] = crossover(parent1, parent2)

parent1 = decoder(parent1);
parent2 = decoder(parent2);

%% definindo a criança como um vetor de zeros (importante para inserir os valores no final)

    child = zeros(1,length(parent1)); 

%% definindo o tamanho do conjunto de genes a serem passados, assim como a coordenada inicial

    swathSize = randi(length(parent1)-2);
    if swathSize < 2
        swathSize = 2;
    end
    swathStart = randi(length(parent1)-swathSize+1);
    
%% inserindo os genes na criança

    child(swathStart:swathStart+swathSize-1) = parent1(swathStart:swathStart+swathSize-1);
    
%% fazendo os ciclos: achar um membro do pai2 que não está na criança, procurar o valor da mesma posição no pai1. Procurar o mesmo valor no pai2, se estiver em uma posição fora do conjunto de genes passados, inserir na criança 
%o valor inicial. Se não, recomeçar.
    for i=1:swathSize
        if ~ismember(parent2(swathStart+i-1), child)
            value = parent2(swathStart+i-1);
            pos = swathStart+i-1;
            while (true)
                [~, pos] = ismember(parent1(pos), parent2);

                if pos < swathStart || pos > swathStart+swathSize-1
                    child(pos) = value;
                    break;
                end
            end
        end
    end
    
%% inserir os valores finais que ficaram de fora do loop
    
    child([child(:) == 0]) = parent2([child(:) == 0]);
    
end
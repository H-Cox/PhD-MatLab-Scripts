
%ID = [1,2,3..];

for z = 1:length(ID)
    
    id = ID(z);
    filename = ['fib ' num2str(id) '.txt'];

    JFilImport
    
    JFilamentends
    clear dr dx dy ff endRow fileID fnum i skip VarName5 X Y xf yf 
    save(['Dynamic fibrils/fibdata ' num2str(id) '.mat'])
    clearvars -except ID
end
close all
    
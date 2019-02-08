
ID = [1,2,3,4,5,6,7,9,10,11,12,13,14,15];

for z = 1:length(ID)
    
    id = ID(z);
    filename = ['s' num2str(id) '.txt'];

    JFilImport
    
    JFilamentends
    clear dr dx dy ff endRow fileID fnum i skip VarName5 X Y xf yf 
    save(['fibdata ' num2str(id) '.mat'])
    clearvars -except ID
end
close all
    
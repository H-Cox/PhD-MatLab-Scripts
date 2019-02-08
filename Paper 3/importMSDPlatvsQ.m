importFibrilNames

allModes = {};

for s = 1:length(savenames)
    
    fibril_ids1 = modeID{s};
    fibril_ids2 = modeID{s+8};
    
    samplepath1 = names{s};
    samplepath2 = names{s+8};
      
    path = [homepath samplepath1];
    disp(path);
    figure;
    data = [];
    for f = 1:length(fibril_ids1)
        disp(['Fibril number ' num2str(f) ', id ' num2str(fibril_ids1(f))]);
        [output] = basicImport(fibril_ids1(f),path);
        hold on;
        plot(output(:,1),output(:,2),'.');
        data = [data; output];
    end
    
    path = [homepath samplepath2];
    disp(path);
    for f = 1:length(fibril_ids2)
        disp(['Fibril number ' num2str(f) ', id ' num2str(fibril_ids2(f))]);
        [output] = basicImport(fibril_ids2(f),path);
        hold on;
        plot(output(:,1),output(:,2),'.');
        data = [data; output];
    end
    
    allModes = [allModes, data];
end


function [output] = basicImport(id,path)

filename = [path 'fibril' num2str(id) '.mat'];
load(filename,'plateaus','Lcval','nmax');

q = (1:nmax).*pi()./Lcval;

output = [q', plateaus];


end
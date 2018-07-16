function [output] = movingHistogram(data,edges)

if ~exist('edges','var') 
    edges = logspaceShiftingBins(min(data(:,1)),max(data(:,1)),10,0.5);
end

output.inputData = data;
output.edges = edges;

minD = -2;%floor(log10(min(data(:,2))));
maxD = 2;%ceil(log10(max(data(:,2))));

dataEdges = logspace(minD,maxD,40);
dataBins = 10.^((log10(dataEdges(2:end))+log10(dataEdges(1:end-1)))/2);

output.dataEdges = dataEdges;
output.dataBins = dataBins;

logEdges = log10(edges);
bins = 10.^((logEdges(:,2)+logEdges(:,1))/2);

output.bins = bins;

for b = 1:length(bins)
    
    tdata = data(data(:,1)>edges(b,1),:);
    tdata = tdata(tdata(:,1)<edges(b,2),:);
    output.data{b} = tdata;
    
    output.dataHist(:,b) = histcounts(tdata,dataEdges,'Normalization','probability')';
    
end

plotonoff = 0;

if plotonoff == 1
    
    figure;
    
    for b = 1:length(bins)
        hold on;
        histogram(counts{b}(:,2),0:0.5:30,'normalization','probability');
    end
    
end

end
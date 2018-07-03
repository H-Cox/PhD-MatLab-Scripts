% Function to produce the histogram counts for logarithmically spaced bins.
% Written by Henry Cox 24/01/2018

function [data] = loghist(varargin)

X = varargin{1};
plotonoff = 0;
in = length(varargin);

if in < 2
    n = round(length(X)/5);
elseif in < 3
    n = varargin{2};
else
    n = varargin{2};
    plotonoff = 1;
end

minX = min(X);
maxX = max(X);

edges = logspace(floor(log10(minX(1))),ceil(log10(maxX(1))),n);
data(:,1) = exp(log(edges(1:end-1)) + (log(edges(2:end))-log(edges(1:end-1)))/2);
data(:,2)= histcounts(X,edges,'Normalization','probability');

if plotonoff == 1
    figure
    plot(data(:,1),data(:,2));

    set(gca, 'xscale', 'log');

    xlabel('MSD (m^{2})');
    ylabel('Probability');
end
    
end
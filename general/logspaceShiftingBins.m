function [edges] = logspaceShiftingBins(min,max,nBins,sizeBins)
% Function by Henry Cox to make lograithmically spaced bins with edges
% which are various sizes.

if ~exist('nBins','var')
    nBins = 10;
end

if ~exist('sizeBins','var')
    sizeBins = 1;
end

logBins = linspace(log10(min),log10(max),nBins)';

logSize = (logBins(2)-logBins(1)).*sizeBins;

edges(:,1:2) = [logBins-logSize, logBins+logSize];

edges = 10.^edges;

end
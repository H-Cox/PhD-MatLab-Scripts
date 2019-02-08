function [out_data,bins] = Histogram2D(varargin)

in_data = varargin{1};

if length(varargin) == 1
    bins = 100;
    plotonoff = 1;
elseif length(varargin) == 2
    bins = varargin{2};
    plotonoff = 1;
else
    bins = varargin{2};
    plotonoff = varargin{3};
end


[row,~] = size(in_data);

if length(bins) == 1
    
    bins = linspace(min(in_data(:)),max(in_data(:)),bins);
    
end

out_data = zeros(row,length(bins)-1);

for r = 1:row
    
    temp = histcounts(in_data(r,:),bins,'Normalization','probability');
    out_data(r,:) = temp;
end

bins = bins(1:end-1) + diff(bins(1:2))/2;

if plotonoff == 1
    surf(out_data)
end
end


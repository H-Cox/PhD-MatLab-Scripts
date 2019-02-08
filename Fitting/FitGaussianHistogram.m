% Function to take some data and calculate a gaussian fit to a histogram of
% its values (or probability distribution). Example use:
% [fit] = FitGaussianHistogram(1D data)
% [fit] = FitGaussianHistogram(1D data, numberofbins)
% [fit] = FitGaussianHistogram(1D data, vector of bin edges to use)
% Written by Henry Cox 01/11/17

function [fit] = FitGaussianHistogram(varargin)

% find the histogram counts for the data
if length(varargin) == 1
    
    % if only data supplied do a histogram as normal
    [counts,bins] = histcounts(varargin{1},'Normalization','pdf');

else
 
    % find the counts and bins    
    [counts,bins] = histcounts(varargin{1},varargin{2},'Normalization','pdf');

end  

% find the centre of each bin
x = bins(1:end-1) + (bins(2)-bins(1))/2; 

% do the fit
[fit] = FitGaussian(x,counts);
% add in the x and y components
fit.x = x;
fit.y = counts;
fit.edges = bins;
fit.ydata = varargin{1};
end



    
    
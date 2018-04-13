% function to fit gaussian profiles to each mode to find the variance
% written by Henry Cox 27/10/17
clear vars amid ravls stds
% find number of frames
m = size(a,2);

% loop through each mode
for i = 1:size(a,1)
    
    % import data
    data = a(i,:);
    
    % find mean and standard dev
    me = nanmean(data);
    st = nanstd(data);
    
    % use them to define histogram edges
    bins = linspace(me-3*st,me+3*st,m/5);
    
    % calculate centre of each bin
    x = bins(1:end-1)+(bins(2)-bins(1))/2;
    
    % determine values of unnormalised pdf
    [counts] = histcounts(data,bins);
    
    % fit gaussian to the counts
    [fit] = FitGaussian(x,counts);
    
    % extract data
    stds(i,:) = fit.xo(3,:);
    amid(i,:) = fit.xo(2,:);
    rvals(i) = sum(fit.R);
    
end

% calculate variance from standard deviation
vars = [stds(:,1).^2, 2.*stds(:,1).*stds(:,2)];
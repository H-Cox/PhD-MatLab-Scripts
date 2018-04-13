% function to fit gaussian profiles to each mode to find the variance at
% different points in the video
% written by Henry Cox 27/10/17
clear vars amid ravls
% find number of frames
m = size(a2,2);

fnums = round(linspace(0,m,6));
figure
for k = 1:5
    
    fdata = a2(:,fnums(k)+1:fnums(k+1));
    
    % loop through each mode
    for i = 1:size(a2,1)
    
        % import data
        data = fdata(i,:);
    
        % find mean and standard dev
        me = mean(data);
        st = std(data);
    
        % use them to define histogram edges
        bins = linspace(me-3*st,me+3*st,m/10);
        
        % calculate centre of each bin
        x = bins(1:end-1)+(bins(2)-bins(1))/2;
    
        % determine values of unnormalised pdf
        [counts] = histcounts(data,bins);
    
        % fit gaussian to the counts
        [fit] = FitGaussian(x,counts);
    
        % extract data
        fstds(i,k) = fit.xo(3,1);
        famid(i,k) = fit.xo(2,1);
        frvals(i) = sum(fit.R);
    
    end
    
hold on
plot(fstds(:,k));
end
% calculate variance from standard deviation
fvars = fstds.^2;


% Function to plot the raw data and fitted gaussian produced by the
% FitGaussianHistogram function.
% Written by Henry Cox 01/11/17

function plotGaussHist(fit)

% open a figure
figure;
% plot a histogram of the raw data
histogram(fit.ydata,fit.edges);
hold on
% plot the gaussian fit over the top
plot(fit.x,fit.yfit,'Linewidth',2)
end
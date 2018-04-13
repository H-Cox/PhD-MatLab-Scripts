% Function to calculate mean and standard deviation of bending energy
% distribution, grouped by contour length, Lc, grouping defined by limits.
function [means,stds] = fitBendEnergyDist(bEnergy,Lc,limits)

means = zeros(1,length(limits)-1);
stds = means;

bEnergy(Lc<limits(1)) = [];
Lc(Lc<limits(1)) = [];

for l = 1:length(limits)-1
    
    means(l) = mean(bEnergy(Lc<limits(l+1)));
    stds(l) = std(bEnergy(Lc<limits(l+1)));
    
    bEnergy(Lc<limits(l+1)) = [];
    Lc(Lc<limits(l+1)) = [];
end

end

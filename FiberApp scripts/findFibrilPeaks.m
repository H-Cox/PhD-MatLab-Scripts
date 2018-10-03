function [peaks] = findFibrilPeaks(intensities,x)

if ~exist('x','var')
    x = linspace(0,1,length(intensities));
end

xx = linspace(min(x),max(x),length(intensities)*10);
rawint = intensities;
intensities = spline(x,intensities,xx);

smoothedIntensities = smoothn(intensities,10000);

ys = findpeaks(smoothedIntensities)';

xs = zeros(size(ys));

for p = 1:length(ys)
    
    xs(p) = xx(smoothedIntensities==ys(p));
    
end

peaks = [xs,ys];

end
function [peaks] = findFibrilPeaks(intensities,x)

if ~exist('x','var')
    x = linspace(0,1,length(intensities));
end

smoothedIntensities = smoothn(intensities,1);

ys = findpeaks(smoothedIntensities)';

xs = zeros(size(ys));

for p = 1:length(ys)
    
    xs(p) = x(smoothedIntensities==ys(p));
    
end

peaks = [xs,ys];

end
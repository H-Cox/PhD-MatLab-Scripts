function [slopeData] = rheologyScalings(rheologyData,limits);
% Power law fit to frequency sweep data sets


if ~exist('limits','var')
    
    limits = [-Inf,Inf];
    
end

x = rheologyData.F(:,1);
y = rheologyData.G1(:,1);

fit = doTheFit(x,y,limits);

slopeData.G1 = fit;
slopeData.yG1 = exp(log(x).*fit(1,1)+fit(1,2));

y = rheologyData.G2(:,1);

fit = doTheFit(x,y,limits);

slopeData.G2 = fit;
slopeData.yG2 = exp(log(x).*fit(1,1)+fit(1,2));

end


function [fit] = doTheFit(x,y,limits)

y = y(x>=limits(1));
x = x(x>=limits(1));

y = y(x<=limits(2));
x = x(x<=limits(2));

fit = linearfit(log(x),log(y));

end

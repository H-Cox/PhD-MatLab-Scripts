function [U] = modes2Energy(a)

amean = nanmean(a,2);

a = a - amean;

U = nansum(a.^2,1);


end

function [y]=gaussian(x,const,mean,sigma)

y = const.*exp(-((x-mean).^2)./(2*sigma.^2));
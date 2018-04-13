
function [score]=G4FitGaussian(mean,var,const)

load('C:\Users\mbcx9hc4\Documents\MATLAB\PhD\Scripts\FitGaussianData.mat');

a=mean./1000;
o=var./1000;
y0=(2.*pi().*o.^2)^(-0.5).*exp(-((x-a).^2)./(2.*o.^2));

yfunc = @(x) (2.*pi().*o.^2)^(-0.5).*exp(-((x-a).^2)./(2.*o.^2));

int=integral(yfunc,x(1),x(end));

y0=y0.*const;

y0 = y0 + y1;

score = sum(abs(y-y0));

%plot(x,y)

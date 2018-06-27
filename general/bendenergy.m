function [U,error] = bendenergy(x,y,n)

% set the units used, e.g. 1e-6 == microns
units = 1e-6;

% set the intrinsic persistence length of the fibrils in metres.
Lp = 2.5e-3;

if exist('n','var') == 0
    n = 25;
end

if length(x) < 40
    xx = linspace(min(x),max(x),40);
    
    yy = spline(x,y,xx);
else
    xx = x;
    yy = y;
end
modefit = NumericalFModes(xx,yy,n);
error = modefit.error;
a = modefit.an;

L = calc_Lc(xx,yy);

q = (1:n).*pi()./L;

U = sum((a(q<1.2).*q(q<1.2)).^2).*Lp./units./2;
end
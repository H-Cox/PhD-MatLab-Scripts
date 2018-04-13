function [G, lags] = xcorrh(x,y)

if exist('y','var')==0
    y = x;
end

x = x - mean(x(:));
y = y - mean(y(:));

[G, lags] = xcorr(x,y,'coeff');

G(lags<0) = [];
lags(lags<0) = [];
end



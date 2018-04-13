function [Lc] = contourLength(x,y)

dx = diff(x);
dy = diff(y);

dr = sqrt(dx.^2+dy.^2);

Lc = sum(dr);
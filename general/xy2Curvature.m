function [curvature] = xy2Curvature(x,y)

dy = diff(y);
dx = diff(x);

dydx = dy./dx;
dydxdx = dydx./dx;

curvature = dydxdx./((1+dydx.^2).^1.5);
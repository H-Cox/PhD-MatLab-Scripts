% Function to calculate the persistence length from each point along the
% fibre.
% Henry Cox 19/12/2016

function [Lp,k] = LpCurvature(xpts,ypts)

% find dx, dy and average difference between points
dx = diff(xpts);
dy = diff(ypts);
dr = mean(sqrt(dx.^2+dy.^2));

% calculate curvature using derivatives
dydx = dy./dx;

ddy = diff(dydx);
ddy(end+1) = ddy(end);

ddydx = ddy./dx;

kd = abs(ddydx)./(1+dydx.^2).^1.5;

% calculate tangent angle at each point
theta = atan(dy./dx);

% calculate theta averaged over two
atheta = (theta(1:end-1)+theta(2:end))./2;
%{
atheta(2:end+1) = atheta;
atheta(1) = atheta(2) - (atheta(3)-atheta(2));
atheta(end+1) = atheta(end) + (atheta(end)-atheta(end-1));
%}

% calculate change in the tangent angle
dtheta = diff(atheta);

% calculate the change in the tangent vector
dt = sqrt(2-2.*cos(dtheta));

% calculate curvature
k = dt./dr;

% calculate persistence length at each point
Lp = 1.19./k;

clear dt dtheta atheta dx dy dr xpts ypts


function [tangents,angle] = TangentRotate2Zero(data,rotateyn)
% function by Henry Cox (23/10/17) to take x, y data = [x,y], find the
% tangent angles along them and then transform those tangent angles such
% that they start and end at zero.

% find difference along the data
d = diff(data);
% calculate tangent angle at each point
tang = atan(d(:,2)./d(:,1));
% set x co-ordinates
xt = 1:length(tang);
% find the angle between first and last point
angle = atan((tang(1)-tang(end))/(xt(1)-xt(end)));
% rotate points so that tangents(1) = tangents(end)
[tangents,tx] = DecomposeMotion([xt',tang],angle);
% subtract so that tangents(1) = tangents(end) = 0
tangents = tangents - tangents(1);

if rotateyn == 0
    tangents = tang;
end
end
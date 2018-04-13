function [tangents,angle] = TangentRotate2Zero(data)
% function by Henry Cox (23/10/17) to take 
d = diff(data);
tang = atan(d(:,2)./d(:,1));
xt = 1:length(tang);
angle = atan((tang(1)-tang(end))/(xt(1)-xt(end)));
[tangents,tx] = DecomposeMotion([xt',tang],angle);
tangents = tangents - tangents(1);
end
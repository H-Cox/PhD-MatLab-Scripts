function [x,y] = angle_to_position(angles,contour_length,offset)

if ~exist('offset','var')
    offset = [0,0];
end

points = length(angles)+1;

point_spacing = contour_length/(points-1);

y = zeros(points,1); x = y;

x(1) = offset(1);
y(1) = offset(2);

for pt = 2:points
    
    x(pt) = x(pt-1)+point_spacing*cos(angles(pt-1));
    y(pt) = y(pt-1)+point_spacing*sin(angles(pt-1));
end
end
function [x1,y1] = RotateTransform(varargin)

if size(varargin{1},1) > 1
    xy = [varargin{1}'; varargin{2}'];
    flag = 1;
else
    xy = [varargin{1}; varargin{2}];
end


if length(varargin) == 3
    
    angle = varargin{3};
    xy0 = [0;0];

elseif length(varargin) == 4
    
    angle = 0;
    xy0 = [varargin{3}; varargin{4}];
    
else
    angle = varargin{3};
    xy0 = [varargin{4}; varargin{5}];
end

xy1 = xy - xy0;

R = [cos(angle), -sin(angle); 
     sin(angle), cos(angle)];
     
xy1 = R*xy1;

x1 = xy1(1,:);
y1 = xy1(2,:);

if exist('flag','var')
    x1 = x1';
    y1 = y1';
end
end
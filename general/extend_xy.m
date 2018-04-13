function [extended_x,extended_y] = extend_xy(x,y,extension)

dx = diff(x);
ddx = diff(dx);

dy = diff(y);
ddy = diff(dy);

x0 = x(1)-dx(1)+mean(ddx(1:4));
y0 = y(1)-dy(1)+mean(ddy(1:4));

xE = x(end) + dx(end) + mean(ddx(end-4:end));
yE = y(end) + dy(end) + mean(ddy(end-4:end));


x = [x0 ; x; xE];
y = [y0 ; y; yE];

extension = extension - 1 ;

if extension > 0
    
    [extended_x,extended_y] = extend_xy(x,y,extension);
else

    extended_x = x;
    extended_y = y;
end

end
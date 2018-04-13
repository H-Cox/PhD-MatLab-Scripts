function [distance] = square_dist(x,y)

distance = sqrt((x(1)-x(end)).^2+(y(1)-y(end)).^2);
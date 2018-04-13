function [L] = calc_Lc(x,y)

dx=diff(x);
dy=diff(y);

dr=sqrt(dx.^2+dy.^2);

L=sum(dr);


%clear x y dx dy dr
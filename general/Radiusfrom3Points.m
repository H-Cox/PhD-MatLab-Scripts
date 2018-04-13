function [radius] = Radiusfrom3Points(xd,yd)

[xd,i] = sort(xd);
yd = yd(i);

x1 = xd(1);
x2 = xd(2);
x3 = xd(3);
y1 = yd(1);
y2 = yd(2);
y3 = yd(3);

mr = (y1-y2)/(x1-x2);
mt = (y3-y2)/(x3-x2);

x = (mr*mt*(y3-y1)+mr*(x2+x3)-mt*(x1+x2))/(2*(mr-mt));

y = -(x-(x1+x2)/2)/mr + (y1+y2)/2;

radius = sqrt((x1-x).^2+(y1-y).^2);
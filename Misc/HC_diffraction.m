function [output] = HC_diffraction(separation)

x = (-10:0.1:10)';

x1 = x-separation/2;
x2 = x+separation/2;

y1 = 2.*besselj(1,x1)./x1;
y2 = 2.*besselj(1,x2)./x2;

output = x;

output = [output, y1, y2];

I1 = y1.^2;
I2 = y2.^2;

I3 = (y1+y2).^2;
I3 = I3./max(I3(:));
output = [output, I1, I2, I3, I1+I2];

end
function [score] = fitanything(b)

global correlation

x = 0:10:1000;
x = x';

model = @(b,x) b(1).*exp(-x.^2./(4.*b(2).^2))+b(3).*cos(pi().*x./(2.*b(4))).*exp(-x./b(5));

%b = [b1,b2,b3,b4,b5];
fit = model(b,x);

c = correlation(1:1:101);
c = c';
score = sum(abs(fit - c));
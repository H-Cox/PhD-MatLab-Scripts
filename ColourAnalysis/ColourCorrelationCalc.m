model = @(b,x) b(1).*exp(-x./b(2))./x;

x = 0:0.020:0.200;
x = x';

c1 = log(mcorrelation(1:11,1));
c2 = log(mcorrelation(1:11,2));

m1a = linearfit(x,c1);
m1b = linearfit(x.^2,c1);

m2a = linearfit(x,c2);
m2b = linearfit(x.^2,c2);

l1a = -1./m1a(1,1);
l1b = sqrt(-1./(4*m1b(1,1)));

l2a = -1./m2a(1,1);
l2b = sqrt(-1./(4*m2b(1,1)));
%{
x = 0.010:0.010:1.000;
x = x';
c1b = correlation(2:1:101,1);
c2b = correlation(2:1:101,2);
b1 = [1,1];
b2 = [1,1];

%m1c = nlinfit(x,c1b,model,b1);
%m2c = nlinfit(x,c2b,model,b2);
%}
hold on

x2 = 0:0.020:1.000;
x2 = x2';

%errorbar(x2,correlation(1:4:101,1),correlation(1:4:101,4));
plot(x2,exp(m1a(1,2)).*exp(m1a(1,1).*x2))
hold on

plot(x2,exp(m2a(1,2)).*exp(m2a(1,1).*x2))
hold on
plot(x2,exp(m1b(1,2)).*exp(m1b(1,1).*x2.^2))
hold on
plot(x2,exp(m2b(1,2)).*exp(m2b(1,1).*x2.^2))
hold on
%plot(x2,model(m1c,x2))
hold on
%plot(x2,model(b2,x2))

%d1 = correlation(1:1:101,1) - exp(m1(1,2)).*exp(m1(1,1).*x2);
%d2 = correlation(1:1:101,2) - exp(m2(1,2)).*exp(m2(1,1).*x2);

%figure

%plot(x2,d1,x2,d2)
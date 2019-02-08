figure;
for p = 1:4
y = -1./decay2(ind+p-1,1);
ey = decay2(ind+p-1,2).*y.^2;
hold on
errorbar(t,y,ey)
end
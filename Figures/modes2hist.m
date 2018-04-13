function modes2hist(mode1, mode2)

figure

dat = [mode1',mode2'];
n = hist3(dat,[20,20]);
n1 = n;
n1(size(n,1)+1,size(n,2)+1) = 0;

xb = linspace(min(dat(:,1)),max(dat(:,1)),size(n,1)+1);
yb = linspace(min(dat(:,2)),max(dat(:,2)),size(n,1)+1);

h = pcolor(xb,yb,n1);

h.ZData = ones(size(n1)) * -max(max(n));
colormap(jet) % heat map
title('Mode historgrams');
colorbar
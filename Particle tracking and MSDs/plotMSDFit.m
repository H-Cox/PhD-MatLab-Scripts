function [taufit,yfit,tauraw,yraw] = plotMSDFit(MSDData)

hold on; %figure;

x = MSDData.meanMSDfeatures.tau;
x2 = logspace(log10(min(x)),log10(min(x))+2,1000);
plot(x,MSDData.meanMSD,'.','markerSize',12)

yfit = exp(polyval(MSDData.meanMSDfeatures.linfit(1,:),log(x2)));

hold on
plot(x2,yfit);
set(gca, 'YScale', 'log')
set(gca, 'XScale', 'log')

tau = x2;
yraw = MSDData.meanMSD;

yfit = yfit(tau<=1)';
yraw = yraw(x<=1);
taufit = tau(tau<=1)';
tauraw = x(x<=1)';
end
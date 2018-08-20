function plotMSDFit(MSDData)

hold on; %figure;

x = MSDData.meanMSDfeatures.tau;
x2 = logspace(log10(min(x)),log10(min(x))+2,1000);
plot(x,MSDData.meanMSD,'.','markerSize',12)

yfit = exp(polyval(MSDData.meanMSDfeatures.linfit(1,:),log(x2)));

hold on
plot(x2,yfit);
set(gca, 'YScale', 'log')
set(gca, 'XScale', 'log')

end
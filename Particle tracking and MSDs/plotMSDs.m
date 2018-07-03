function plotMSDs(MSDdata)

figure;

tau = taugen(100,size(MSDdata.MSDs,1));
hold on;
loglog(tau,MSDdata.MSDs','Color',[128,191,255]./255,'LineWidth',1);

hold on;

errorbar(tau,MSDdata.meanMSD,MSDdata.stdMSD,'Color',[0,128,255]./255,'LineWidth',2)

end
function plotMSDs(MSDdata)

MSDs = MSDdata.MSDs(:,MSDdata.goodRH==1);

%figure;

tau = taugen(100,size(MSDs,1));
hold on;
loglog(tau,MSDs','Color',[128,191,255]./255,'LineWidth',1);

hold on;

errorbar(tau,MSDdata.meanMSD,MSDdata.stdMSD,'Color',[0,128,255]./255,'LineWidth',2)

end
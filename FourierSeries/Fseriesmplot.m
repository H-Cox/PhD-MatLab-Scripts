function Fseriesmplot(Frames)

figure

for k = 2:length(Frames)
    
    plot(Frames(k).modefit.smid,...
       Frames(k).modefit.tangents-mean(Frames(k).modefit.tangents),...
        '--.','MarkerSize',20,'LineWidth',2);
    hold on 
    plot(Frames(k).modefit.s,Frames(k).modefit.Theta,...
        'LineWidth',3);
    pause(0.1)
    hold off
end
end

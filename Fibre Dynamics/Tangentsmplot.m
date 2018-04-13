
figure
for i = 1:n
    
    hold off
    subplot(1,2,1)
    plot(Frames(i).tangents)
    axis([0 40 -2E-1 +2E-1])
    subplot(1,2,2)
    hold on
    plot(Frames(i).tangents)
    axis([0 40 -1E-1 +1E-1])
    pause(0.1)
end

P2s = [];

for i = 1:length(Images)
    Images(i).P2s = 1.5.*cos(Images(i).atheta-Images(i).direction(1)).^2-0.5;
    Images(i).P2 = mean(Images(i).P2s);
    P2s = [P2s ; Images(i).P2];
end

P2 = mean(P2s);
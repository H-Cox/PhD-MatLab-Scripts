
figure
for i = 1:size(perps,2)
    
    hold on
    plot(linspace(i,i,size(perps,1)),perps(i,:),'.')
end
function colourPlot(x,y,newFigure)

len = length(x);

colourmap = colormap(parula(len));

if ~exist('newFigure','var')
    figure;
end

for point = 1:len-1
    
    hold on;
    
    plot(x(point:point+1),y(point:point+1),'Color',colourmap(point,:))
    
end

end
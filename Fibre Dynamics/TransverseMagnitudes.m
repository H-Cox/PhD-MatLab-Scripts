
segments = linspace(min(x2),max(x2),50);

xsegs = (segments(2:end)+segments(1:end-1))./2;

for i = 1:length(xsegs)
    
    index1 = find(x2<segments(i+1));
    yindex1 = y2(index1);
    xindex1 = x2(index1);
    index2 = find(xindex1>segments(i));
    
    ypoints = (yindex1(index2));        
    ymag(i) = (max(ypoints) - min(ypoints))./2;
    msu(i) = mean(ypoints.^2);
    
end

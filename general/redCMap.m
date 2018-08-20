function [cmap] = redCMap(length)

cmap = ones(length,3);

cmap(1:length,2) = linspace(0,0.7,length);
cmap(1:length,3) = cmap(1:length,2);

end

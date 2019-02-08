function [new_y] = convertToNewX2D(old_x,old_y,new_x,gaussianSigma)

if ~exist('gaussianSigma','var')
    gaussianSigma = 0.05;
end

if size(new_x,1) == 1    
    new_x = new_x';
end
    
if size(old_x,1) == 1    
    old_x = old_x';
end

[~, cols] = size(old_y);

new_y = zeros([length(new_x),cols]);

for c = 1:cols
    
    tempY = convertToNewX(old_x,old_y(:,c),new_x,gaussianSigma);
    
    new_y(:,c) = tempY(:,1);
    
end

end
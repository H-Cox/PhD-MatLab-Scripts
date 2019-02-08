function [new_y] = convertToNewX(old_x, old_y, new_x, gaussianSigma)

new_y = zeros([length(new_x),2]);


if ~exist('gaussianSigma','var')
    gaussianSigma = 0.05;
end

for z = 1:length(new_x)
   
                
    weights = gaussweighting(old_x,new_x(z),gaussianSigma);
            
    new_y(z,1) = nansum(weights.*old_y)./nansum(weights);
    new_y(z,2) = nanstd(weights.*old_y);        

end

end
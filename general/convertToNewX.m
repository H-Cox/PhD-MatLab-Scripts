function [new_y] = convertToNewX(old_x, old_y, new_x)

new_y = zeros(size(new_x));


for z = 1:length(new_x)

                
    weights = gaussweighting(old_x,new_x(z),0.05);
            
    new_y(z) = nansum(weights.*old_y)./nansum(weights);
            

end

end
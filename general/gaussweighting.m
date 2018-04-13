function [weight] = gaussweighting(x,mean,std)

    fmean = 1/sqrt(2.*pi().*std.^2);
    
    fx = 1/sqrt(2.*pi().*std.^2)*exp(-(x-mean).^2/(2.*std.^2));
    
    weight = fx./fmean;
    
end
    
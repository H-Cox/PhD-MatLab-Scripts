function [weight] = exp2weighting(x,mean,decay)

    fx = abs(x-mean);
    
    weight = exp(-(fx).^2./decay);
    
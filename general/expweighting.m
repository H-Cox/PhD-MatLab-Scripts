function [weight] = expweighting(x,mean,decay)

    fx = abs(x-mean);
    
    weight = exp(-fx./decay);
    
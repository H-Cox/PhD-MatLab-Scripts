function [weightedmean] = wmean(data,errors)
    data(errors == NaN) = [];
    errors(errors == NaN) = [];
    errors(data == NaN) = [];
    data(data == NaN) = [];
    
    xo = data.*(errors).^-2;
    
    sume = sum(errors.^-2);
    
    weightedmean(2) = sqrt(1/sume);
    
    weightedmean(1) = sum(xo)/sume;
    
end
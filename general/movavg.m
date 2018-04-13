function [mavg] = movavg(data,l)

    if rem(l,2) ~= 0;
        l = l-1;
    end
    
    x = 1:length(data);
    
    for i = 1:length(data);
        
        dx = abs(x-i);
        
        mavg(i) = nanmean(data(dx<=l/2));
    end
end

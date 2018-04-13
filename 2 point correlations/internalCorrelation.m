function [G] = internalCorrelation(x,y)

x1 = x;
y1 = y;

for s = 1:80
    
    % calculate distance between points seperated by distance s at all
    % times
    dx = x1(1:end-s,:)-x1(1+s:end,:);
    dy = y1(1:end-s,:)-y1(1+s:end,:);
    dr = sqrt(dx.^2+dy.^2);

    for t = 0:999
        
        % divide dr(t+to) by dr(to)
        Gtemp = dr(:,1+t:end)./dr(:,1:end-t);
        
        % average over all to and all particle combinations
        G(s,t+1) = nanmean(Gtemp(:));
        
    end
    
end

end

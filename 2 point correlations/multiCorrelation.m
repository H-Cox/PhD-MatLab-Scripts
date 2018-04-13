function [G,Ge] = multiCorrelation(x,y)

for f = 1:length(x)
    [r(f),c(f)] = size(x{f});
end

cmin = min(c)-10;

xf = [];
yf = [];
id = [];
for f = 1:length(x)
    x{f} = x{f}(1:round(r(f)*0.9),1:cmin);
    y{f} = y{f}(1:round(r(f)*0.9),1:cmin);
    ids = ones(round(r(f)*0.9),1).*f;
    
    xf = [xf; x{f}];
    yf = [yf; y{f}];
    id = [id;ids];
end

mx = mean(xf,2);
my = mean(yf,2);

pts = length(mx);
s_raw = zeros(pts);
for p = 1:pts
    
    s_raw(1+p:pts,p) = sqrt((mx(p)-mx(p+1:end)).^2+(my(p)-my(p+1:end)).^2);
end

sc = round(s_raw);

s = 24;

for spt = 1:max(s)
    
    [G(spt,:),Ge(spt,:)] = calculateG(xf,yf,spt,sc,pts,id);
    
end


end



function [Gtemp,Gtempe] = calculateG(xf,yf,spt,sc,pts,id)
    disp(['Working on a distance of ' num2str(spt)]);
    index = find(sc==spt);
    
    p1 = rem(index,pts)+1;
    p2 = ceil(index./pts);
    
    selfcheck = id(p1)-id(p2);
    
    
    % set test as == for only with other fibrils (external)
    % set test as ~= for only with its own fibril (internal)
    p1(selfcheck==0) = [];
    p2(selfcheck==0) = [];
    
    xTest1 = xf(p1,:);
    xTest2 = xf(p2,:);
    yTest1 = yf(p1,:);
    yTest2 = yf(p2,:);
    
    dx = xTest1-xTest2;
    dy = yTest1-yTest2;
    dr = sqrt(dx.^2+dy.^2);
    dr(dr==0) = NaN;
    dr(dr==Inf) = NaN;
    
    
    timepoints = 0:25:2500;
    
    for t = 1:length(timepoints)
        
        % divide dr(t+to) by dr(to)
        Gt = corrh(dr(:,1+timepoints(t):end),dr(:,1:end-timepoints(t)));
        
        % average over all to and all particle combinations
        
        Gtemp(t) = nanmean(Gt(:));
        Gtempe(t) = nanstd(Gt(:));
       
    end   
    %{
    for t = 1:length(dr(:,1))
        
        % divide dr(t+to) by dr(to)
        %Gt = dr(:,1+timepoints(t):end)./dr(:,1:end-timepoints(t));
        
        [Gtc(t,:),~] = xcorrh(dr(t,:));
        % average over all to and all particle combinations
        
        
        
    end   
    Gtemp = nanmean(Gtc,1);
    Gtempe = nanstd(Gtc,1);
    %}
end

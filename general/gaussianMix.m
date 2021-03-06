function [fit] = gaussianMix(data,k,fixedParams)

if ~exist('fixedParams','var')
    rp = 0;
    fixedParams = [];
else
    [rp,~] = size(fixedParams);
end    

[n,~] = size(data);

extent = range(data);
rdata = repmat(data,[1,k]);

% initialise variables
tempParams = rand(2,k-rp).*extent;

% means need to be within data set
tempParams(1,:) = tempParams(1,:)+min(data);
% make variance smaller
tempParams(2,:) = sqrt(tempParams(2,:));

% integrate fixed parameters
params = [fixedParams, tempParams];

% initialise weights
params(3,:) = rand(1,k);
params(3,:) = params(3,:)./sum(params(3,:));

% calculate responsibilities
r = zeros([n,k]);
for g = 1:k
    r(:,g) = params(3,g).*gaussian(data,params(1,g),params(2,g));
end

denom = nansum(r,1);

% calculate new parameters
diff = 1;
iter = 2;
logLh(1) = 1;

while diff > 0.0001
    
    Nc = sum(r,1);
    
    params(1,1+rp:end) = sum(r(:,1+rp:end).*data,1)./Nc(1+rp:end);
    
    params(2,1+rp:end) = sqrt(sum(r(:,1+rp:end).*(rdata(:,1+rp:end)-params(1,1+rp:end)).^2,1)./Nc(1+rp:end));
    
    diff = sqrt(sum((params(3,:)-Nc./n).^2));
    
    params(3,:) = Nc./n;
    
    rt = zeros([n,k]);
    
    for g = 1:k
        rt(:,g) = params(3,g).*gaussian(data,params(1,g),params(2,g));
    end
    
    denom = nansum(rt,1);
    r = rt./denom;
  
    logLh(iter) = findLogLikelyhood(rt);
    iter = iter + 1;
    
    diff = abs(logLh(iter-2)-logLh(iter-1));
end

fit.xo = params;

fit.x = linspace(min(data),max(data),1000);

rt = zeros([k,1000]);
for g = 1:k
    rt(g,:) = params(g,3).*gaussian(fit.x,params(g,1),params(g,2));
end

fit.y = sum(rt,1);
fit.logLh = logLh;

end


function logLikelyhood = findLogLikelyhood(data)
logLikelyhood = nansum(log(nansum(data,1)),2);
end
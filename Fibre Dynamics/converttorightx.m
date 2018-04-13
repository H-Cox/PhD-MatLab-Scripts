function [times,y,e2] = converttorightx(lengthscales, correlation_data,x)
if exist('x','var') == 0
    
    x = 0:1:40;
end
l = lengthscales;
co = correlation_data;
x = x';
clear y e2
yall =[];
for z = 1:length(x)
    
    yt = [];
    
    for p = 1:length(l)
        
        xtest = l{p};

        if x(z) <= max(xtest(:))
            
            weights = gaussweighting(xtest,x(z),0.1);
            weights = repmat(weights,[1,size(co{p},2)]);
            weights = weights;
            
            yinsert = nansum(weights.*co{p},1)./nansum(weights,1);
            
            yt(p,1:length(yinsert)) = yinsert;           
        end
    end
    cx{z} = repmat(x,[1,length(l)]);
    xy{z} = yt;
    try 
    y(z,1:size(yt,2)) = nanmean(HenryMethod(yt));
    %yall = [yall ; HenryMethod(yt)];
    e2(z,1:size(yt,2)) = nanstd(HenryMethod(yt));
    end
end

times = 0:0.01:((size(y,2)/100)-0.01);
times = repmat(times,[size(y,1),1]);

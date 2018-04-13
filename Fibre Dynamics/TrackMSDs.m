% script to remove tracks based on certain criteria

i = 1;
j = length(objects3);

% loop which cycles through localisations until all meet the criteria
while i <= j;
    
    for k = 1:length(objects3(i).perp)
        
        objects3(i).perpmsd(k) = mean((objects3(i).perp(1:end-k)-objects3(i).perp(1+k:end)).^2);
        objects3(i).paramsd(k) = mean((objects3(i).para(1:end-k)-objects3(i).para(1+k:end)).^2);
        
        perpmsd3(k,i) = objects3(i).perpmsd(k);
        paramsd3(k,i) = objects3(i).paramsd(k);
        
        
    end
       
    i = i+1;    
    
end

perpmsd3(perpmsd3==0) = NaN;
paramsd3(paramsd3==0) = NaN;

perpmsdend = nanmean(perpmsd3,2);
paramsdend = nanmean(paramsd3,2);
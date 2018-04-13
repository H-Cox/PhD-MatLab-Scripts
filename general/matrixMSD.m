function [MSD] = matrixMSD(data)

for i = 1:size(data,1)
        
    MSD(i) = nanmean(sum((data(1+i:end,:)-data(1:end-i,:)).^2,2));
    
end

end
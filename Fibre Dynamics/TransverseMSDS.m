function [MSD,errors] = TransverseMSDS(data)

[space_points, time_points] = size(data);
%{
for p = 1:space_points
    
    data(p,:) = (data(p,:)-nanmean(data(p,:))) / nanstd(data(p,:));
    data(p,isnan(data(p,:))) = 0;
    
end
%}

for p = 0:space_points
    
    temp_MSD = zeros(space_points-p,time_points);
    
    for q = 1:space_points-p
        
        [very_temp_MSD] = crossMSD(data(q,:),data(q+p,:));
        
        temp_correlation(q,:) = very_temp_MSD;
        
    end
    
    MSD(p+1,:) = nanmean(temp_correlation,1);
    errors(p+1,:) = nanstd(temp_correlation,1);
end

end
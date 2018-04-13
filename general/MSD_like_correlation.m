function [correlation_data,errors] = MSD_like_correlation(data)

[space_points, time_points] = size(data);

for p = 1:space_points
    data(p,:) = data(p,:) - smoothn(data(p,:),1E8);
    data(p,:) = (data(p,:)-nanmean(data(p,:))) / nanstd(data(p,:));
    data(p,isnan(data(p,:))) = 0;
    
end


for p = 0:space_points
    
    temp_correlation = zeros(space_points-p,time_points);
    
    for q = 1:space_points-p
        
        [very_temp_correlation,lag] = xcorr(data(q,:),data(q+p,:),'biased');
        
        temp_correlation(q,:) = very_temp_correlation(lag>=0);
        
    end
    
    correlation_data(p+1,:) = nanmean(temp_correlation,1);
    errors(p+1,:) = nanstd(temp_correlation,1);
end

end
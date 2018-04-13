function [correlation_data] = crossMSD_like_correlation(data1,data2)

[sp(1), time_points1] = size(data1);
[sp(2), time_points2] = size(data2);

space_points = max(sp);
time_points = min([time_points1, time_points2]);

d1 = HenryMethod(zeros(space_points,time_points));
d2 = d1;

d1(1:sp(1),1:end) = data1(1:sp(1),1:time_points);
d2(1:sp(2),1:end) = data2(1:sp(2),1:time_points);

for p = 1:space_points
    d1(p,:) = d1(p,:)-smoothn(d1(p,:),1E8);
    d1(p,:) = (d1(p,:)-nanmean(d1(p,:))) / nanstd(d1(p,:));
    d1(p,isnan(d1(p,:))) = 0;
    
    d2(p,:) = d2(p,:)-smoothn(d1(p,:),1E8);
    d2(p,:) = (d2(p,:)-nanmean(d2(p,:))) / nanstd(d2(p,:));
    d2(p,isnan(d2(p,:))) = 0;
    
end

total_space_points = sum(sp) - 2;
minsp  = min(sp);

% loop through available space points
for p = 1:minsp
    
    temp_correlation = zeros(p,time_points);

    for q = 0:p-1
        
        [very_temp_correlation,lag] = xcorr(d1(q+1,:),d2(p-q,:),'biased');
        
        temp_correlation(q+1,:) = very_temp_correlation(lag>=0);
        
    end
    
    correlation_data(p,:) = nanmean(temp_correlation,1);
    %errors(p,:) = nanstd(temp_correlation,1);
end

end
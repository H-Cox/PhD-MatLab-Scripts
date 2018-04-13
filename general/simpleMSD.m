% Function to calculate the MSD of n dimensional data, where the input has
% dimensions = columns and temporal data in rows.
% Henry Cox 09/17

function [MSD] = simpleMSD(data)

% loop through lag times
for i = 1:size(data,1)
    
    % calculate the MSD for this lag time
    MSD(i) = nanmean(sum((data(1+i:end,:)-data(1:end-i,:)).^2,2));
    
end
end
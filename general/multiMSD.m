function [output] = multiMSD(data)

[~, datasize] = size(data);

parfor k = 1:datasize
    
    m(k,:) = simpleMSD(data(:,k));
    
end

output = m;


end
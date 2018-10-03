function [S] = gyrationTensor(input)

CoM = mean(input);

rData = input-CoM;

for r = 1:size(input,2)
    
    for c = 1:size(input,2)
        
        S(r,c) = mean(input(:,r).*input(:,c));
        
    end
    
end

end

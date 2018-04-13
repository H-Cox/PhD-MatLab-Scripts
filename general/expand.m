function [output] = expand(input,n)

count = 1;
output = zeros(length(input)*n,1);
for i = 1:length(input)
    
    for k = 1:n
    
        output(count) = input(i);
        
        count = count + 1;
        
    end
end
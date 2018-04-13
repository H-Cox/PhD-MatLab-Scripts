function [fibril1, fibril2] = breakage(fiber)
    fiber = fiber(fiber~=0);
    if length(fiber) > 3
    
        b = randi(length(fiber)-3);
    
        fibril1 = fiber(1:b+1);
        fibril2 = fiber(b+2:end);
    else
        fibril1 = fiber;
        fibril2 = [];
    end
end
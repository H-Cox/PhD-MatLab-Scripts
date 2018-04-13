function [len] = fibrillength(fiber)
    
    len = length(fiber) - length(fiber(fiber==0));
end
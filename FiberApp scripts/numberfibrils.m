

nfibs = [];

for i = 1:length(Images);
    
    nfibs = [nfibs; length(Images(i).xy)];
    
end

allfibs = sum(nfibs);
mfibs = [mean(nfibs) , std(nfibs)];
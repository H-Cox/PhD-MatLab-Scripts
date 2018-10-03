function [pVc] = extractpVc(Images)

pVc = [];

for im = 1:length(Images)
    
    for f = 1:length(Images(im).pVc(:,1))
        
        pVc = [pVc; Images(im).combinedPVC{f}];
                
    end
    
end
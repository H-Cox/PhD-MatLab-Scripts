function Images = combinePvC(Images)

for im = 1:length(Images)
    
    for f = 1:length(Images(im).modefit)
        Images(im).combinedPVC{f} = [];
        
        for p = 1:size(Images(im).pVc,2)
            Images(im).combinedPVC{f} = [Images(im).combinedPVC{f}; Images(im).pVc{f,p}]; 
        end
        
        [~,index] = sort(Images(im).combinedPVC{f}(:,1));
        Images(im).combinedPVC{f} = Images(im).combinedPVC{f}(index,:);
        
    end
end

end
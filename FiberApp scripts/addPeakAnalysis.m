function Images = addPeakAnalysis(Images,rawImages)

in = cell(length(Images),1);

[Images.fint] = in{:};
[Images.peaksxy] = in{:};
[Images.meanPeak] = in{:};
[Images.stdPeak] = in{:};

for im = 1:length(Images)
    
    theseRawImages = cell(1,size(rawImages,2));
    
    for c = 1:size(rawImages,2)
        theseRawImages{c} = rawImages{im,c};
    end
    
    Images(im) = fibrilPeakAnalysis(Images(im),theseRawImages);
    
end

end
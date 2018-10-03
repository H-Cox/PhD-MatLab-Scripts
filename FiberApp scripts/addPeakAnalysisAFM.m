function Images = addPeakAnalysisAFM(Images)

in = cell(length(Images),1);

[Images.fint] = in{:};
[Images.peaksxy] = in{:};


for im = 1:length(Images)
    
    Images(im).fint = Images(im).z_nm;
    Images(im) = fibrilPeakAnalysisAFM(Images(im));
    
end

end
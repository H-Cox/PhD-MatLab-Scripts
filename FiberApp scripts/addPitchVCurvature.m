function [Images] = addPitchVCurvature(Images)

for im = 1:length(Images)
    
    for f = 1:length(Images(im).modefit)
        
        for pol = 1:size(Images(im).peaksxy{f},2)
            
            peaks = Images(im).peaksxy{f}{pol}(:,1);
            curvature = Images(im).modefit(f).Curvature;
            smid = Images(im).modefit(f).smid;
            
            Images(im).pVc{f,pol} = doCalculation(peaks,curvature,smid);
            
        end
        
    end
end

Images = combinePvC(Images);

end     

function [result] = doCalculation(peaks,curvature,smid)

averageC = zeros(length(peaks)-1,1);
pitch = averageC;
sVal = pitch;

for p = 1:length(peaks)-1
    averageC(p) = mean(abs(curvature(smid>peaks(p) & smid<peaks(p+1))));
    pitch(p) = peaks(p+1)-peaks(p);
    sVal(p) = mean([peaks(p+1),peaks(p)]);
end

result = [sVal, pitch, averageC];

end
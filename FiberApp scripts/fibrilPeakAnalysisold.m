function [fibrilData] = fibrilPeakAnalysisold(fibrilData,image1,image2)

if ~exist('image2','var')
    oneimage = 1;
else
    oneimage = 0;
end


for f = 1:length(fibrilData.xy)
    if oneimage==1
        [fibrilData.fint{f}{1},tpeaks] = processFibril(image1,fibrilData.xy{f});
        fibrilData.peaksxy{f}{1}=tpeaks.*fibrilData.length_nm(f);
    else
        
        [fibrilData.fint{f}{1},tpeaks] = processFibril(image1,fibrilData.xy{f});
        fibrilData.peaksxy{f}{1}=tpeaks.*fibrilData.length_nm(f);
        
        [fibrilData.fint{f}{2},tpeaks] = processFibril(image2,fibrilData.xy{f});
        fibrilData.peaksxy{f}{2}=tpeaks.*fibrilData.length_nm(f);
        
        fibrilData.meanPeak(f,1:2)=[mean(diff(fibrilData.peaksxy{f}{1}(:,1))),mean(diff(fibrilData.peaksxy{f}{2}(:,1)))];
        fibrilData.stdPeak(f,1:2)=[std(diff(fibrilData.peaksxy{f}{1}(:,1))),std(diff(fibrilData.peaksxy{f}{2}(:,1)))];
        fibrilData.stdPeak(f,3:4) = fibrilData.stdPeak(f,1:2)./[length(fibrilData.peaksxy{f}{1}),length(fibrilData.peaksxy{f}{2})];
    end
end

end

function [intensities, peaks] = processFibril(image, fibrilCoords)

    intensities = getIntensity(image,fibrilCoords);
    
    peaks = findFibrilPeaks(intensities);
    
end
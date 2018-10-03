function [fibrilData] = fibrilPeakAnalysis(fibrilData,images)

for f = 1:length(fibrilData.xy)
           
    for im = 1:length(images)
    
        [fibrilData.fint{f}{im},tpeaks] = processFibril(images{im},fibrilData.xy{f});
        fibrilData.peaksxy{f}{im}=tpeaks.*fibrilData.length_nm(f);
        
        fibrilData.meanPeak(f,im) = mean(diff(fibrilData.peaksxy{f}{im}(:,1)));
        fibrilData.stdPeak(f,im) = std(diff(fibrilData.peaksxy{f}{im}(:,1)));
        
    end
end

end

function [intensities, peaks] = processFibril(image, fibrilCoords)

    intensities = getIntensity(image,fibrilCoords);
    
    peaks = findFibrilPeaks(intensities);
    
end
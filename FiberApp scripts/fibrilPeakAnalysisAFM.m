function [fibrilData] = fibrilPeakAnalysisAFM(fibrilData)


for f = 1:length(fibrilData.xy)
    
        [tpeaks] = findFibrilPeaks(fibrilData.fint{f});
        fibrilData.peaksxy{f}{1}=tpeaks.*fibrilData.length_nm(f);
        
end

end
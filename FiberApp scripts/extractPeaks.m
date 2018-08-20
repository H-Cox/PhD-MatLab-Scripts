function peaks = extractPeaks(fibrilData)

peaks = [];

for f = 1:length(fibrilData.peaksxy)
    
    peaks = [peaks; fibrilData.peaksxy{f}{1}(:,1)];
    
end

end
        
        
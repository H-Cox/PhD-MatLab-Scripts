% run colour matcher and fibre colour blocks first

% set the segment length in units of nm
SL = 100;

SL = SL/10;

SegmentRatio = [];

% loop through images
for z = 1:length(Images)
    
    % loop through fibres
    for j = 1:length(Images(z).xy)
        
        steps = floor(length(Images(z).counts{j})/SL);
        
        for i = 1:SL:steps*SL
            
            TotalCounts = sum(Images(z).counts{j}(i:i+SL-1,3));
            AFCounts = sum(Images(z).counts{j}(i:i+SL-1,1));
            
            SegmentRatio = [SegmentRatio; AFCounts/TotalCounts];
        end
    end
end
SegmentRatio100 = SegmentRatio.*100;


% tr array format:
%   Each output array is a table with the following columns:
%       Column 1: X position in whole image (pixels)
%       Column 2: Y position in whole image (pixels)
%       Column 3: frame number
%       Column 4: particle number - unique number identifying particle
%       Column 5: radius (pixels)
%       Column 6: J
%       Column 7: eccentricity - equals 0 for circles, 1 for lines/ridges
%       Column 8: rotation (radians) of particle's major axis
%       Column 9: average brightness of pixels within particle
%       Column 10: skewness
%       Column 11: motion perpendicular to fibre director
%       Column 12: motion parallel to fibre director
%       Column 13: MSD perpendicular to director
%       Column 14: MSD parallel to director

clear allperpMSD allparMSD perpMSD parMSD

% gradient of linear fit to fibre
m = 3.5418;

% calculate angle associated with gradient of fibre
director = atan(m);

% number of tracks
n = length(tr);

% loop through all tracks decomposing motion and appending tr
for i = 1:n
    
    % find length of track
    m = length(tr{i}(:,10));
    
    % decompose motion
    [tr{i}(:,11),tr{i}(:,12)] = DecomposeMotion(tr{i}(:,1:2),director);
    
    % loop through available lag times in track
    for j = 1:m-1
        
        % calculate MSD for each lag time
        tr{i}(j,13:14) = (mean(tr{i}(1:end-j,11:12)-tr{i}(j+1:end,11:12),1)).^2;
        
    end
    
    % copy MSDs out into parent variable to be averaged
    allperpMSD(1:m-1,i) = tr{i}(1:m-1,13);
    allparMSD(1:m-1,i) = tr{i}(1:m-1,14);
        
end

allperpMSD(allperpMSD == 0) = NaN;
allparMSD(allparMSD == 0) = NaN;

perpMSD = nanmean(allperpMSD,2);
parMSD = nanmean(allparMSD,2);















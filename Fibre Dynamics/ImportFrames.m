% script to place localisation data into a structure grouped by frame id

% if you haven't imported localisations yet run this script!
ImportLocalisations

% counts through frame number
i = 1;

% counts through localisation number
j = 1;

% main loop counting through until the final data point is processed or
% final frame is reached
while i <= max(frame) && j <= length(frame)
    
    % imports first localisation in this frame
    if data(j).frame == i
        framedata(i).xy = [data(j).xnm, data(j).ynm];
        framedata(i).uncertaintynm = [data(j).uncertaintynm];
        framedata(i).sigmanm = [data(j).sigmanm];
        framedata(i).chi2 = [data(j).chi2];
        framedata(i).intensityphoton = [data(j).intensityphoton];
        framedata(i).offsetphoton = [data(j).offsetphoton];
        framedata(i).bkgstdphoton = [data(j).bkgstdphoton];
        
        % move onto next localisation
        j = j + 1;
    end
    
    % imports any other localisations in this frame
    while j<= length(frame) && data(j).frame == i;
        
        framedata(i).xy = [framedata(i).xy ; data(j).xnm, data(j).ynm];
        framedata(i).uncertaintynm = [framedata(i).uncertaintynm ;data(j).uncertaintynm];
        framedata(i).sigmanm = [framedata(i).sigmanm ;data(j).sigmanm];
        framedata(i).chi2 = [framedata(i).chi2 ;data(j).chi2];
        framedata(i).intensityphoton = [framedata(i).intensityphoton ;data(j).intensityphoton];
        framedata(i).offsetphoton = [framedata(i).offsetphoton ;data(j).offsetphoton];
        framedata(i).bkgstdphoton = [framedata(i).bkgstdphoton ;data(j).bkgstdphoton];
        
        % move onto next localisation
        j = j + 1;
        
    end
    
    % move onto next frame
    i = i + 1;
    
end

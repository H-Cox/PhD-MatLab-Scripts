% script to collect the localisations data from thunderSTORM into a data
% structure for processing

% counter for localisation number
i = 1;

% loops until all localisations are processed
while i <= length(frame)
    
        data(i).frame = frame(i);
        data(i).xnm = xnm(i);
        data(i).ynm = ynm(i);
        data(i).uncertaintynm = uncertaintynm(i);
        data(i).sigmanm = sigmanm(i);
        data(i).chi2 = chi2(i);
        data(i).intensityphoton = intensityphoton(i);
        data(i).offsetphoton = offsetphoton(i);
        data(i).bkgstdphoton = bkgstdphoton(i);
        
        % proceed to next localisation
        i = i + 1;
end

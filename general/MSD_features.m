function [features] = MSD_features(MSD,framerate)

[number_MSDs,~] = size(MSD);

if number_MSDs > 10
    parfor n = 1:number_MSDs
        features(n) = MSD_features(MSD(n,:),framerate);
    end
elseif number_MSDs > 1
    for n = 1:number_MSDs
        features(n) = MSD_features(MSD(n,:),framerate);
    end
else

    features.framerate = framerate;
    features.frames = length(MSD);
 
    features.plateau = MSDPlateau(MSD');
    features.tau = taugen(framerate, features.frames)';
    quarter = round(features.frames/4);
    features.linfit = linearfit(log(features.tau(3:quarter)),...
        log(MSD(3:quarter)));
    features.alpha = features.linfit(1);
    features.minq = min(MSD(1:quarter));
end
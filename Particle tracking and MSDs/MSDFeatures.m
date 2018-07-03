function [features] = MSDFeatures(MSD,framerate)

[number_MSDs,~] = size(MSD);

if number_MSDs > 10
    parfor n = 1:number_MSDs
        features(n) = MSDFeatures(MSD(n,:),framerate);
    end
elseif number_MSDs > 1
    for n = 1:number_MSDs
        features(n) = MSDFeatures(MSD(n,:),framerate);
    end
else

    features.framerate = framerate;
    features.frames = length(MSD);
 
    features.plateau = MSDPlateau(MSD');
    features.tau = taugen(framerate, features.frames)';
    quarter = 20; %round(features.frames/4);
    features.linfit = linearfit(log(features.tau(1:quarter)),...
        log(MSD(1:quarter)));
    features.alpha = features.linfit(1);
    features.minq = min(MSD(1:quarter));
    
    % if the MSD is linear with time then calculate the effective
    % hydrodynamic radius assuming the solvent is water and the temperature
    % is 20degC
    if round(features.alpha,0) == 1
        
        features.hydrodynamicRadius = findHydrodynamicRadius(features.linfit(:,2),293.15);

    else
        
        features.hydrodynamicRadius = [NaN,NaN];
    end
end
function [features] = basicMSDFeatures(MSD,framerate)
MSD = double(MSD);
features.framerate = framerate;
features.frames = length(MSD);
 
features.tau = taugen(framerate, features.frames);
quarter = max([4,min([20,round(features.frames/4)])]);
features.linfit = linearfit(log(features.tau(1:quarter)),...
	log(MSD(1:quarter)));

features.alpha = features.linfit(1);
features.minq = min(MSD(1:quarter));

features.hydrodynamicRadius = findHydrodynamicRadius(features.linfit(:,2),293.15);

end
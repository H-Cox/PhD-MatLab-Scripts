function [features] = basicMSDFeatures(MSD,framerate)
MSD = double(MSD);
features.framerate = framerate;
features.frames = length(MSD);
 
features.tau = taugen(framerate, features.frames);
quarter = max([4,min([20,round(features.frames/4)])]);
features.loglinfit = linearfit(log(features.tau(1:quarter)),...
	log(MSD(1:quarter)));

features.alpha = features.loglinfit(1);
features.minq = min(MSD(1:quarter));
logDiffCoeff = exp(features.loglinfit(1,2));
logDiffCoeff(2,1) = logDiffCoeff(1,1).*features.loglinfit(2,2);

features.linfit = linearfit(features.tau(1:quarter),MSD(1:quarter));

features.diffusionCoeff = [features.linfit(:,1), logDiffCoeff]./4;

features.hydrodynamicRadius = findHydrodynamicRadius(features.diffusionCoeff,293.15);

end
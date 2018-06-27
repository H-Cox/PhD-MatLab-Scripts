function [MSDdata] = processPolyParticleTracks(tr,framerate)

% Output array format for each track:
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

if ~exist('framerate','var')
    framerate = 100;
end

MSDdata.framerate = framerate;

% import track data into MSDdata.tracks
MSDdata.tr = tr;

MSDdata.meanskey = {'x position','y position','frame number','particle number',...
    'radius','J','eccentricity','rotation','brightness','skewness','video number'};

for p = 1:length(tr)
    MSDdata.means(p,:) = nanmean(MSDdata.tr{p},1);

    MSDdata.trackLength(p) = size(MSDdata.tr{p},1);

    MSDdata.x(1:MSDdata.trackLength(p),p) = MSDdata.tr{p}(:,1);
    MSDdata.y(1:MSDdata.trackLength(p),p) = MSDdata.tr{p}(:,2);
       
    MSDdata.MSDs(1:MSDdata.trackLength(p),p) = simpleMSD(MSDdata.tr{p}(:,1:2));

end

MSDdata.x = HenryMethod(MSDdata.x);
MSDdata.y = HenryMethod(MSDdata.y);
MSDdata.MSDs = HenryMethod(MSDdata.MSDs);

MSDdata.dx = diff(MSDdata.x);
MSDdata.dy = diff(MSDdata.y);
MSDdata.dr = sqrt(MSDdata.dx.^2+MSDdata.dy.^2);

MSDdata.meandr = nanmean(MSDdata.dr);
MSDdata.area = (max(MSDdata.x)-min(MSDdata.x))...
    .*(max(MSDdata.y)-min(MSDdata.y));

MSDdata.meanMSD = nanmean(MSDdata.MSDs,2);
MSDdata.meanMSDfeatures = MSD_features(MSDdata.meanMSD',framerate);

try
    MSDdata.MSDfeatures = MSD_features(MSDdata.MSDs,framerate);
catch
    disp('could not extract detailed features');
end

end

% calcualte alpha for each MSD and put into MSD.alpha



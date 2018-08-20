function [MSDdata] = processPolyParticleTracks(tr,framerate,pixelsize)

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

if ~exist('pixelsize','var')
    pixelsize = 0.13e-6;
end

% import data into MSDdata
MSDdata.framerate = framerate;
MSDdata.pixelsize = pixelsize;
MSDdata.tr = tr;

MSDdata.meanskey = {'x position','y position','frame number','particle number',...
    'radius','J','eccentricity','rotation','brightness','skewness','video number'};

for p = 1:length(tr)
    MSDdata.means(p,:) = nanmean(MSDdata.tr{p},1);

    MSDdata.trackLength(p) = size(MSDdata.tr{p},1);

    MSDdata.x(1:MSDdata.trackLength(p),p) = MSDdata.tr{p}(:,1).*pixelsize;
    MSDdata.y(1:MSDdata.trackLength(p),p) = MSDdata.tr{p}(:,2).*pixelsize;
       
    MSDdata.MSDs(1:MSDdata.trackLength(p),p) = simpleMSD(MSDdata.tr{p}(:,1:2).*pixelsize);
    
    MSDdata.features(p) = basicMSDFeatures(MSDdata.MSDs(1:MSDdata.trackLength(p),p),framerate);
    
    MSDdata.alphas(p) = MSDdata.features(p).alpha;
    MSDdata.rHs(p,1:2) = MSDdata.features(p).hydrodynamicRadius(1,:);
    
    if MSDdata.MSDs(6,p) > 4e-14% && MSDdata.rHs(p,2)/MSDdata.rHs(p,1)<0.3 && MSDdata.rHs(p,2)/MSDdata.rHs(p,1)>0
        MSDdata.goodRH(p) = 1;
    else
        MSDdata.goodRH(p) = 0;
    end
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
MSDdata.stdMSD = nanstd(MSDdata.MSDs,0,2);
MSDdata.meanMSDfeatures = MSDFeatures(MSDdata.meanMSD',framerate);

MSDdata.goodMSDs=MSDdata.MSDs(:,MSDdata.goodRH==1);

MSDdata.goodMeanMSD = nanmean(MSDdata.goodMSDs,2);
MSDdata.goodStdMSD = nanstd(MSDdata.goodMSDs,0,2);
MSDdata.goodMeanMSDfeatures = MSDFeatures(MSDdata.goodMeanMSD',framerate);
end




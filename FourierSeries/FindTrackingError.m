% input your choices

% smoothing factor 0 => no smoothing
sf = 0;
% 0 => no plotting, 1=> plot graphs
plotyn = 0;
% longest wavelength for fourier series in units of fibril length
lh = 1;
% maximum number of modes
nmax = 25;
% fibril length in microns
L = Lcval;

%{
% find the relaxed conformation of the fibril
[PP,image] = FindPP(xyf);

% extract nm co-ordinates
data = PP(:,3:4);

% perform smoothing
sdata = beziersmoothing(data(2:end-1,:),abs(sf));

ddata = diff(sdata);
tangents = atan(ddata(:,2)./ddata(:,1));
LcPP = sum(sqrt(sum(ddata.^2,2)))/1000;
% calculate tangents
%[tangents,angle]=TangentRotate2Zero(sdata,0);

% s, scalar value along the fibril
s = pi*(2*((1:length(tangents))-1)/(length(tangents)-1))/lh;
s = s';

% find fourier amplitudes for relaxed conformation
[main] = NumericalFModes(PP(:,3),PP(:,4),nmax);

at = main.an';
%}

at = nanmean(a,2);

% find difference between relaxed and vibrating modes
ad = bsxfun(@minus,at,a(:,1:end));

% square difference and average for each mode
adm = nanmean(ad.^2,2);

% define modes
n = 1:nmax;
n = n';

% begin calculation of mean-squared error for fibril localisation
% sin term
sn = sin(n.*pi()./(2.*length(dx)-2)).^2;
sn = sn.*(length(dx)-2);

% calculate e^2, 
e2 = adm./(1+sn);
e2 = e2.*(L./4);


% calculate the error terms for each mode
e = sqrt(abs(e2));

% calculate the average tracking error in nm
meanerror = 1000*mean(e(10:end));

% if plotting, plot...
if plotyn == 1
   % figure; imshow(image)
    
    figure;plot(n,e)
end



% Function to find the primitive path of a fibril given JFilament tracks,
% input data should be in two rows, x in first, y in second. In units of
% nanometers. 
% Henry Cox 09/10/2017 
function [primPath,image] = FindPP(xyfdata)

% convert to nm
xyfdata(:,1:2) = xyfdata(:,1:2).*1000;

% import data for test fibril
xtest = xyfdata(xyfdata(:,3)==min(xyfdata(:,3))+1,1);
ytest = xyfdata(xyfdata(:,3)==min(xyfdata(:,3))+1,2);

dr = mean(sqrt(diff(xtest).^2+diff(ytest).^2));
n = ceil(dr/10);

% interpolate x,y co-ordinates to generate 10nm point spacing
[xd,yd] = JFilamentinterp(xyfdata,n);
data = [xd, yd]';

% size of pixels [nm] in the generated image, should be larger than point
% spacing
pxlscale = 20;

% generate image from track points
[image,minima] = xy2image(data,pxlscale);

% set = 0 for no plotting, or = 1 to display plots 
plotonoff = 1;

% set slice length in units of nm
lslice = 50;

% extend image to ensure slices do not go off the edges
im = imadd10(image,lslice);

% extract x y co-ordinates of test fibril, usually from second frame as 
% that has the best fit 
xpts = (xtest-minima(1))./pxlscale+lslice;
ypts = (ytest-minima(2))./pxlscale+lslice;
xpts = interpo(xpts,4);
ypts = interpo(ypts,4);

pts = [xpts', ypts'];

% find dx, dy
dx = diff(xpts);
dy = diff(ypts);

% calculate tangent angle at each point
theta = atan(dy./dx);
theta(end+1) = theta(end);

% convert to normal
normal = theta + pi()./2;

% determine co-ordinates at each end of the slice (+/- l pixels from 
% fibril)
x1 = xpts' - lslice.*cos(normal)';
x2 = xpts' + lslice.*cos(normal)';
y1 = ypts' - lslice.*sin(normal)';
y2 = ypts' + lslice.*sin(normal)';

if plotonoff == 1
    figure;
    imshow(im);
    hold on;
    plot(xpts,ypts);
end

% set number of points on the slice, best is 10 per pixel
n = 10*lslice;

% find co-ordinates of each point on each slice
for k = 1:length(x1)
	xsec = linspace(x1(k),x2(k),n)';
	ysec = linspace(y1(k),y2(k),n)';
	xc(:,k) = xsec;
	yc(:,k) = ysec;
    if plotonoff == 1
        hold on;
        plot(xsec,ysec,'Linewidth',2);
    end
end

% extract pixels values at each slice co-ordinate
ind = sub2ind(size(im),ceil(yc(:)),ceil(xc(:)));
iml = im(:);
vals = iml(ind);
if plotonoff == 2
    figure
end

% x co-ordinates for fitting
xfit = linspace(-lslice,lslice,n);

% loop through each slice and fit a gaussian
for k = 1:length(vals)/n
    
    % extract pixel values for the slice and normalise
	pixels = vals(1+(k-1)*n:k*n);
    pixels = pixels./max(pixels(:));
    
    % fit the gaussian and record mean and sigma
	f(k) = ezfit(xfit,pixels,'gauss');
	means(k) = f(k).m(3);
	width(k) = f(k).m(2);
    
    % convert to x and y co-ordinates
    xPP(k,1) = xpts(k)+means(k)*cos(normal(k));
    yPP(k,1) = ypts(k)+means(k)*sin(normal(k));
    
    if plotonoff == 2
        hold on;
        plot(xfit,pixels);
        hold on;
        plot(xfit,f(k).m(1).*exp(-((xfit-f(k).m(3)).^2)./(2*f(k).m(2).^2)));
    end
end

% save x and y co-ordinates in pixel units and in nm (uncorrected)
primPath = [xPP, yPP,...
    (xPP-lslice).*pxlscale+minima(1), (yPP-lslice).*pxlscale+minima(2)];

width(mean(k)>2) = [];
means(means(k)>2) = [];

mw = nanmean(width);
sw = nanstd(width);
wid = width(width<mw+3*sw).*pxlscale;
mw = nanmean(wid);
sw = nanstd(wid);


disp(['Average tube width of ' num2str(mw,3) ' +/- ' num2str(sw,2) ' nm.']);
hold off
end




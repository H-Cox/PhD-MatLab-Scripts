% Function to calculate the persistence length from each point along the
% fibre.
% Henry Cox 26/09/2017
clear xc yc width f dx dy dr theta normal x1 x2 y1 y2 hadWarning means
plotonoff = 0;
lslice = 14;

im = imadd10(Images(inum).rawim,lslice);
% extract x y co-ordinates of fibril
xpts = Images(inum).xy{fnum}(1,:)+lslice;
ypts = Images(inum).xy{fnum}(2,:)+lslice;
pts = [xpts', ypts'];
% find dx, dy and average difference between points
dx = diff(xpts);
dy = diff(ypts);
dr = mean(sqrt(dx.^2+dy.^2));

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

for k = 1:length(x1)
	xsec = linspace(x1(k),x2(k),n)';
	ysec = linspace(y1(k),y2(k),n)';
	xc(:,k) = xsec;
	yc(:,k) = ysec;
    if plotonoff == 1
        hold on;
        plot(xsec,ysec);
    end
end
        
ind = sub2ind(size(im),ceil(yc(:)),ceil(xc(:)));
iml = im(:);
vals = iml(ind);
xfit = linspace(-lslice,lslice,n);
if plotonoff == 1
    figure
end

gaussian = @(b,x)(b(4)+b(1).*exp(-((x-b(2))./b(3)).^2./2));

clear f means width hadWarning

for k = 1:length(vals)/n
	pixels = vals(1+(k-1)*n:k*n);
	%bgd = mean([pixels(1:round(n/5)); pixels(end-round(n/5):end)]);
	%pixels = pixels - bgd;
    
    lastwarn(''); % Clear last warning message
     
	f(k) = nlinfit2(xfit,pixels,gaussian,[1,0,1,0]);
	means(k,1:2) = f(k).xo(2,1:2);
	width(k,1:2) = f(k).xo(3,1:2);
    
    [warnMsg, warnId] = lastwarn;
    
    if ~isempty(warnMsg)
        hadWarning(k) = 1;
    else
        hadWarning(k) = 0;
    end
    
    if plotonoff == 1
        hold on;
        plot(xfit,pixels);
        hold on;
        plot(f(k).x,f(k).yfit);
        
    end
end

Images(inum).hadWarning{fnum} = hadWarning;
Images(inum).width{fnum} = width;
Images(inum).mean{fnum} = means;
Images(inum).theta{fnum} = theta;

clear dt dtheta atheta dx dy dr xpts ypts ysec y1 y2 yc xsec xfit xc x2 x1
clear vals pts pixelsize pixels n lastfit k ind iml im bgd


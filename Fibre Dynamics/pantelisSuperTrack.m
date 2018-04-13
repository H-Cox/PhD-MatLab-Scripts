% written by Henry Cox, inspired by Pantelis' code to track the position of
% a fibril.

function [data] = pantelisSuperTrack(videoFilename,relax_x,relax_y)
warning('off')
pixelScale = 0.13; 

video = VideoReader(videoFilename);

numberFrames = video.Duration*video.FrameRate;

xpts = relax_x./pixelScale;
ypts = relax_y./pixelScale;

% set slice length in units of pixels
lslice = 6;
n = lslice*10;
x = xpts + lslice;
y = ypts + lslice;

[xc,yc,normal] = generateSlices(x,y,lslice);

for i = 1:numberFrames
    disp(i);
    video.CurrentTime = (i-1)/video.FrameRate;
    
    im = readFrame(video);
    
    im = imadd10(im,lslice);
    
    % extract pixels values at each slice co-ordinate
    ind = size(im,1).*(ceil(xc(:))-1)+ceil(yc(:));
    iml = im(:);
    vals = double(iml(ind));
    
    % x co-ordinates for fitting
    xfit = linspace(-lslice,lslice,n)';
    
    % loop through each slice and fit a gaussian
    for k = 1:length(vals)/n
    
        % extract pixel values for the slice and normalise
        pixels = vals(1+(k-1)*n:k*n);
        pixels = pixels./max(pixels(:));
        
        try
            % fit the gaussian and record mean and sigma
            f(k) = FitGaussian(xfit,pixels);
            
            if abs(f(k).xo(2,1)) > 6 || f(k).xo(3,1) > 3
                means(k,1:2) = [NaN,NaN];
                width(k,1:2) = [NaN,NaN];
            else
                means(k,1:2) = f(k).xo(2,:);
                width(k,1:2) = f(k).xo(3,:);
            end
        catch
            means(k,1:2) = [NaN,NaN];
            width(k,1:2) = [NaN,NaN];
        end
    
        % convert to x and y co-ordinates
        xPP(k,1) = x(k)+means(k,1)*cos(normal(k));
        yPP(k,1) = y(k)+means(k,1)*sin(normal(k));
    
    
    end
    
    data.means{i} = means;
    data.widths{i} = width;
    data.transverse(:,i) = means(:,1);
    data.xpts(:,i) = xPP;
    data.ypts(:,i) = yPP;
       
end
warning('on')
end




function [xc,yc,normal] = generateSlices(xpts,ypts,lslice)

plotonoff = 0;

pts = [xpts, ypts];

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
end


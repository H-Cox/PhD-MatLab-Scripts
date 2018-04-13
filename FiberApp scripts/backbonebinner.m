% Script written by Henry Cox 01/04/2017
% Creates binary images of tracked fibrils in each image, where bright
% pixels are placed at the backbone co-ordinates of each pixel.
% Used when calculating the mesh size of fibres in an image.


clear pixel x y xy minx miny maxx maxy pxy column pixel
% initialise variable to collect all xy points
xy = [];

% define final pixel size (should be equal to or greater than FiberApp
% point spacings (e.g. 30nm) to avoid gaps in fibrils
if exist('pxl')

else
    pxl = 30;
end
if isempty(pxl)
    pxl = 30;
end

% loop through all fibres, should be performed on images individually
for i = imagenumber
    for j = 1: length(Images(i).xy_nm)
        % collect xy co-ordinate
        xpts = interpo(Images(i).xy_nm{j}(1,:),1)';
        ypts = interpo(Images(i).xy_nm{j}(2,:),1)';
        xy = [xy, [xpts;ypts]];
    end
end

% determine extent of fibrils in image
minx = floor(min(xy(1,:))/pxl)*pxl;
maxx = ceil(max(xy(1,:))/pxl)*pxl;
miny = floor(min(xy(2,:))/pxl)*pxl;
maxy = ceil(max(xy(2,:))/pxl)*pxl;

% define pixels
x = minx:pxl:maxx;
y = miny:pxl:maxy;

% count co-ordinates in each column and row, can be used to compare
% alignment distribution (albeit roughly)
[Nx,edges,bin] = histcounts(xy(1,:),x);
Ny = histcounts(xy(2,:),y);

% loop through all columns
for i = 1:length(x)-1
    
    % find y co-ordinates for each fibril point in column
    column = xy(2,(bin==i));
    
    % plot into the right pixel bin
    pixel(i,:) = histcounts(column,y);
    
end

% copy out pixel array and set any >0 ==1
pixel = pixel';
pxy = pixel;
pxy(pixel>0) = 1;

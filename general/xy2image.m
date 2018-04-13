% Written by Henry Cox (06/10/17) to convert a list of co-ordinates or
% localisations into an image. Inputs are list of xy co-ordinates, pixel
% size in the units of the xy list and optionally 'bw' if you want the
% output to be a bw image (e.g. pixel intensity either 1 or 0)

function [image,minima] = xy2image(varargin)
% import xy list and pixels size
xy = varargin{1};
pxl = varargin{2};
% check bw option and set accordingly
if length(varargin) == 2
    bw = 0;
else
    if varargin{3} == 'bw'
        bw = 1;
    else
        bw = 0;
    end
end

% determine extent of fibrils in image
minx = floor(min(xy(1,:))/pxl)*pxl;
maxx = ceil(max(xy(1,:))/pxl)*pxl;
miny = floor(min(xy(2,:))/pxl)*pxl;
maxy = ceil(max(xy(2,:))/pxl)*pxl;

minima = [minx,miny];

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

% copy out pixel array and set any >0 ==1 if bw option is on
pixel = pixel';
image = pixel;
if bw == 1
    image(pixel>0) = 1;
else
    image = image./max(image(:));
end
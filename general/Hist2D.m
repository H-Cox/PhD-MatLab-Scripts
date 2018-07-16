function [H] = Hist2D(Data,edges)
% from https://stackoverflow.com/questions/6777609/fast-2dimensional-histograming-in-matlab?noredirect=1&lq=1


%# some random data
X = Data(:,1);
Y = Data(:,2);

%# bin centers (integers)
if ~exist('edges','var')
    xbins = floor(min(X)):0.1:ceil(max(X));
    ybins = floor(min(Y)):0.1:ceil(max(Y));
else
    xbins = edges{1};
    ybins = edges{2};
end

xNumBins = numel(xbins); yNumBins = numel(ybins);

%# map X/Y values to bin indices
Xi = round( interp1(xbins, 1:xNumBins, X, 'linear', 'extrap') );
Yi = round( interp1(ybins, 1:yNumBins, Y, 'linear', 'extrap') );

%# limit indices to the range [1,numBins]
Xi = max( min(Xi,xNumBins), 1);
Yi = max( min(Yi,yNumBins), 1);

%# count number of elements in each bin
H = accumarray([Yi(:) Xi(:)], 1, [yNumBins xNumBins]);

%# plot 2D histogram
imagesc(xbins, ybins, H), axis on %# axis image
colormap hot; colorbar
hold on, plot(X, Y, 'b.', 'MarkerSize',1), hold off
end
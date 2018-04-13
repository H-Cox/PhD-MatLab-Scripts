% Script to calculate the mesh size of fibrils in images from a Fiberapp
% images structure. Run ImageDatatoStruct.m first!
% Written by Henry Cox 01/11/17

clear Px Py Ptot Pa Pb

% define the images to use
idxs = 1:length(Images);

% define pixel size and step size in nm, both should be larger than the
% native pixel size of the original images used to ensure there is no gaps
% along fibrils
pxl = 200;
stepnm = 200;
Ptot = [];

% loop through the images
for i = idxs
    
    % set the imagenumber to the current image
    imagenumber = idxs(i);
    
    % run the backbonebinner app to create a black and white image of the
    % fibrils.
    backbonebinner;
    
    % backbonebinner changes, i so set it back to what it should be.
    i = imagenumber;
    
    % Save the black and white image
    Images(i).bbimage = pxy;
    
    % find the size of the image
    maxx = length(pixel(:,1));
    maxy = length(pixel(1,:));
    
    % loop through counting each row and column finding the distance
    % between intersections along that row or column
    for j = 1:max(size(pixel))
        % if j is less than or equal to number of columns check columns
        if j <= maxy
            % find difference between any points which contain a fibril
            Pa = diff(find(pxy(:,j)==1));
            % save the values to Py
            Py(1:length(Pa),j) = Pa;
        end
        % do similar for the rows
        if j <= maxx
            Pb = diff(find(pxy(j,:)==1))';
            Px(1:length(Pb),j) = Pb;
        end
    end
    
    % extract the data and combine together
    P = [Px(:);Py(:)];
    % remove any that came out as zero or one as they are in the same
    % fibril
    P(P==0)=[];
    P(P==1)=[];
    % save the data to the image struct
    Images(i).P = P;
    Images(i).Py = Py;
    Images(i).Px = Px;
    
    % save to the combined differences for all the images
    Ptot = [Ptot; P];
end  
Ptot = Ptot(Ptot>min(Ptot));
try
% fit to an exponential distribution
efit = fitdist(Ptot.*pxl.*0.001,'Exponential');
mesh = [efit.mu, sqrt(efit.ParameterCovariance)];

catch
% if you don't have the statistics and machine learning toolbox we can fit
% the data another, slightly less accurate way

% calculate step size in pixels, minimum should be 2pixels
step = max([2, ceil(stepnm/pxl)]);

% bin steps and set up X variable
Y = histcounts(Ptot,2:step:step*100);
X = 2:step:step*99;

% convert x back to microns
X = 0.001.*pxl.*X(Y>0);
Y = Y(Y>0);

% perform linear fit avoiding -Inf errors
fit = linearfitplot(X(2:end-15),log(Y(2:end-15)));

% try to calculate using a true exponential fit
try
    expfit = FitExp(X(2:end),Y(2:end),[exp(fit(1,2)),fit(1,1)]);
    figure; plot(X(2:end),Y(2:end),X(2:end),expfit.yfit)
    % calculate the mesh size
    mesh = -1/expfit.xo(2,1);
    mesh(2) = (fit.xo(2,2)./(fit.xo(2,1).^2));
% sometimes it throws a NaN or Inf error, if so use the linear fit.
catch
    warning('Problem using exponential fit.  Using linear fit to y = log(a)+b*log(x).');
    % calculate mesh size and error from linear fit in microns
    mesh = -1/fit(1,1);
    mesh(2) = fit(2,1)/(fit(1,1).^2);
end
end

clear fit step P Pb Px Py Pa i lslice k j fnum inum column pxy
clear bin ans edges Nx Ny pixel pxl y ypts x xpts xy xy1 xy2 plotonoff
        
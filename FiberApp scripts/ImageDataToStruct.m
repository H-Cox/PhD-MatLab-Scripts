% Script written by Henry Cox 01/2017
% Script exports data from the FiberApp ImageData file structure and
% performs post processing to determine persistence length, contour length,
% end to end distances etc 

% remove old Images structure and initiate property variables
%clear Images

% input pixel size in um and number of images
pixelsize = 0.13;
numberofimages = 1;
if exist('Images','var')
    w = length(Images);
else
    w = 0;
end

% loop through all Images
for i = 1:length(imageData)
    
    % export main properties from FiberApp
    Images(w+i).name = imageData(1,i).name;
    Images(w+i).sizeX = imageData(1,i).sizeX;
    Images(w+i).sizeY = imageData(1,i).sizeY;
    Images(w+i).sizeX_nm = imageData(1,i).sizeX_nm;
    Images(w+i).sizeY_nm = imageData(1,i).sizeY_nm;
    Images(w+i).xy = imageData(1,i).xy;
    Images(w+i).z = imageData(1,i).z;
    Images(w+i).xy_nm = imageData(1,i).xy_nm;
    Images(w+i).z_nm = imageData(1,i).z_nm;
    Images(w+i).length_nm = imageData(1,i).length_nm;
    Images(w+i).height_nm = imageData(1,i).height_nm;
    %    
    % loop through each fiber
    for j = 1:length(Images(w+i).xy)
        
        % apply correction for pixel size
        Images(w+i).xy_nm{j} = pixelsize.*Images(w+i).xy_nm{j};
        
    end
    
    % apply pixel size corrections to other factors in structure
    Images(w+i).sizeX_nm = pixelsize.*Images(w+i).sizeX;
    Images(w+i).sizeY_nm = pixelsize.*Images(w+i).sizeY;
    Images(w+i).length_nm = pixelsize.*Images(w+i).length_nm;
    %}
       
end

clear Lp k xpts ypts i j sLp number
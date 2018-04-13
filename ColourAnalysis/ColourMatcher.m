% Script to count localisations from two data sets which are on or around
% fibre backbones.
% Created by Henry Cox.

% set the distance in nm to collect localisations around each fibre
% backbone
threshold = 50;

AFCY = [0,0];
% loop through all images
for z = 1:length(Images);
    
% Iniate proportions variable
    Images(z).proportions = [0,0];

% loop through each fibre in the image
    for j = 1:length(Images(z).xy_nm)
    
        disp(['Beginning analysis of fibre ' num2str(j) ' of ' num2str(length(Images(z).xy_nm)) '.'])
        
        % import x and y points of fibre and define boundingbox + threshold
        xpts = Images(z).xy_nm{j}(1,:);
        ypts = Images(z).xy_nm{j}(2,:);
    
        maxx = max(xpts) + threshold;
        minx = min(xpts) - threshold;
        maxy = max(ypts) + threshold;
        miny = min(ypts) - threshold;
        
        % create extra points on fibre backbone (seperated by 10nm)
        xpts2 = interpo(xpts,3);
        ypts2 = interpo(ypts,3);
        pts = [xpts2,ypts2];
        %{
        % Initially count the AF647nm localisations
        Images(z).AF{j} = [0,0];
        
        % Import only localisations within bounding box
        data = XYSnip(Images(z).dataAF,maxy,maxx,miny,minx);
        
        % loop through all points on the fibre
        for i = 1:length(pts)
            clear dx dy dr 
            dx = data(:,1)-pts(i,1);
            dy = data(:,2)-pts(i,2);
    
            dr = sqrt(dx.^2+dy.^2);
            
            % collect localisations which are closer than the threshold
            if min(dr) > threshold
                % move onto next point if none are closer than threshold
                continue
            end
            
            % add data points which are closer than threshold
            Images(z).AF{j} = [Images(z).AF{j}; data(dr<=threshold,1:2)];
            
            % remove localisations already added to fibre
            data(dr<=threshold,:) = [];
        
        end
        
        % tidy up
        Images(z).AF{j} = Images(z).AF{j}(2:end,:);
        Images(z).AFsize(j) = length(Images(z).AF{j});
        
        %}
        % Now count the CY3B 568nm localisations
        Images(z).CY{j} = [0,0];
        data = XYSnip(Images(z).dataCY,maxy,maxx,miny,minx);
    
        for i = 1:length(pts)
            clear dx dy dr 
            dx = data(:,1)-pts(i,1);
            dy = data(:,2)-pts(i,2);
    
            dr = sqrt(dx.^2+dy.^2);
    
            if min(dr) > threshold
                continue
            end
    
            Images(z).CY{j} = [Images(z).CY{j}; data(dr<=threshold,1:2)];
    
            data(dr<=threshold,:) = [];
    
        end
        Images(z).CY{j} = Images(z).CY{j}(2:end,:);
        Images(z).CYsize(j) = length(Images(z).CY{j});
    
        if Images(z).CYsize(j) == 0;
            Images(z).CYsize(j) = 1E-10;
        end
    
%        Images(z).ratio(j) = Images(z).AFsize(j)./Images(z).CYsize(j);
%       Images(z).AFCY(j,1:2) = [100*Images(z).ratio(j)/(Images(z).ratio(j)+1) , 100/(Images(z).ratio(j)+1)];
       
    %}
    end

%AFCY = [AFCY; Images(z).AFCY];

end

% tidy up
%AFCY = AFCY(2:end,:);
clear data dr dx dy i j maxx maxy minx miny pts threshold xpts xpts2 ypts ypts2 z

% run the colour by length script if desired
%ColourbyLength
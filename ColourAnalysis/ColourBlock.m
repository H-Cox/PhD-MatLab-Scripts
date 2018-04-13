function [output] = ColourBlock(fibrexy,AF,CY)
% Function to calculate localisations in 10nm sections of a fibre, needs
% fibre xy co-ordinates and a list of localisations to test.
    for j = 1:length(fibrexy)
        disp(['Fibre ' num2str(j) ' of ' num2str(length(fibrexy)) '.'])
        xpts = interpo(fibrexy{j}(1,:),3);
        ypts = interpo(fibrexy{j}(2,:),3);
    
        pts = [xpts,ypts];
    
        data = AF{j};
    
        blockpts{j} = zeros(length(pts),3);
        counts{j} = zeros(length(pts),3);
        
        for threshold = 1:50;
        
            for i = 1:length(pts);
                clear dx dy dr 
                dx = data(:,1)-pts(i,1);
                dy = data(:,2)-pts(i,2);
    
                dr = sqrt(dx.^2+dy.^2);
    
                if min(dr) > threshold
                    continue
                end
    
                blockpts{j}(i,1) = 1;
                counts{j}(i,1) = counts{j}(i,1) + size(data(dr<=threshold,:),1);
                
                data(dr<=threshold,:) = [];
            end
        end
    
        clear data
    
        data = CY{j};
        
        for threshold = 1:50;
        
            for i = 1:length(pts);
                clear dx dy dr 
                dx = data(:,1)-pts(i,1);
                dy = data(:,2)-pts(i,2);
    
                dr = sqrt(dx.^2+dy.^2);
    
                if min(dr) > threshold
                    continue
                end
    
                blockpts{j}(i,2) = 1;
                counts{j}(i,2) = counts{j}(i,2) + size(data(dr<=threshold,:),1);
                
                data(dr<=threshold,:) = [];
            end
        end
    
        blockpts{j}(:,3) = blockpts{j}(:,1).*blockpts{j}(:,2);
        counts{j}(:,3) = counts{j}(:,1)+counts{j}(:,2);
        blockpts{j}(blockpts{j}==0)=-1;
        output{j} = [ blockpts{j}, counts{j}];
    end   
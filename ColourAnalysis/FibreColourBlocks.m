% run colour matcher first then this then colour by segment

nImages = length(Images);

for z = [1,2,3];

    disp(['Image ' num2str(z) ' of ' num2str(nImages) '.']);
    for j = 1:length(Images(z).xy_nm)
        disp(['Fibre ' num2str(j) ' of ' num2str(length(Images(z).xy_nm)) '.'])
        xpts = interpo(Images(z).xy_nm{j}(1,:),3);
        ypts = interpo(Images(z).xy_nm{j}(2,:),3);
    
        pts = [xpts,ypts];
        
        %data = Images(z).AF{j};
    
        Images(z).blockpts{j} = zeros(length(pts),3);
        Images(z).counts{j} = zeros(length(pts),3);
        %{
        for threshold = 1:50;
        
            for i = 1:length(pts);
                clear dx dy dr 
                dx = data(:,1)-pts(i,1);
                dy = data(:,2)-pts(i,2);
    
                dr = sqrt(dx.^2+dy.^2);
    
                if min(dr) > threshold
                    continue
                end
    
                Images(z).blockpts{j}(i,1) = 1;
                Images(z).counts{j}(i,1) = Images(z).counts{j}(i,1) + size(data(dr<=threshold,:),1);
                
                data(dr<=threshold,:) = [];
            end
        end
    
        clear data
        %}
        data = Images(z).CY{j};
        
        for threshold = 1:50;
        
            for i = 1:length(pts);
                clear dx dy dr 
                dx = data(:,1)-pts(i,1);
                dy = data(:,2)-pts(i,2);
    
                dr = sqrt(dx.^2+dy.^2);
    
                if min(dr) > threshold
                    continue
                end
    
                Images(z).blockpts{j}(i,2) = 1;
                Images(z).counts{j}(i,2) = Images(z).counts{j}(i,2) + size(data(dr<=threshold,:),1);
                
                data(dr<=threshold,:) = [];
            end
        end
        %
        Images(z).blockpts{j}(:,3) = Images(z).blockpts{j}(:,1).*Images(z).blockpts{j}(:,2);
        Images(z).counts{j}(:,3) = Images(z).counts{j}(:,1)+Images(z).counts{j}(:,2);
        Images(z).blockpts{j}(Images(z).blockpts{j}==0)=-1;
        %}
    end   
        
end       
function [Image] = ImagefromLocalisations(Localisations,pixelsize)

    xpts = Localisations(:,1);
    ypts = Localisations(:,2);
    data = [xpts,ypts];
    
    for i = 1:size(data,1);
        data(i,3) = i;
    end
    
    height = ceil(max(ypts)./pixelsize);
    width = ceil(max(xpts)./pixelsize);
    
    for y = 1:height
        
        col = data(data(:,2)<=y*pixelsize,1:3);
        
        if isempty(col)
            Image(1:width,y) = 0;
            continue
        end
        
        for x = 1:width
            if isempty(col)
                Image(x:width,y) = 0;
                break
            end
            clear pts
            pts = col(col(:,1)<=x*pixelsize,:);
            Image(x,y) = size(pts,1);
            col(col(:,1)<=x*pixelsize,:) = [];
            data(pts(:,3),:)=[];
        end
    end
    
counter = 1;
clear atheta alltheta thetas
for i = 1:length(Images)
           
    Images(i).thetas = [];
    for j = 1:length(Images(i).xy_nm)

        dx=diff(Images(i).xy_nm{j}(1,:));
        dy=diff(Images(i).xy_nm{j}(2,:));
        dr=sqrt(dx.^2+dy.^2);

        Images(i).theta{j}=atan(dy./dx);
        
        
        for k = 1:length(Images(i).theta{j})
            
            while Images(i).theta{j}(k) >= pi()
                
                Images(i).theta{j}(k) = Images(i).theta{j}(k) - pi();
            end
            
            while Images(i).theta{j}(k) < 0
                
                Images(i).theta{j}(k) = Images(i).theta{j}(k) + pi();
                
            end
        end
        
        Images(i).atheta(j) = mean(Images(i).theta{j});   
        thetas(1:length(Images(i).theta{j}),counter) = Images(i).theta{j}';  
        
        Images(i).thetas = [Images(i).thetas, Images(i).theta{j}];
        
        counter = counter + 1;
        
    end
    
    [Images(i).N,Images(i).edges] = histcounts(Images(i).thetas,50);
    
    Images(i).direction = Images(i).edges(Images(i).N==max(Images(i).N));
    
end
alltheta = [];
for i = 1:length(thetas(1,:))
    for k = 1:length(thetas(:,i))
        if sum(thetas(k:end,i)) == 0
                
                thetas(k:end,i) = NaN;
                break
        end
                       
    end
    atheta(i) = nanmean(thetas(:,i));
    alltheta = [alltheta ; thetas(:,i)];
    
    alltheta(alltheta == NaN) = [];
end


AFCYscaled = [0,0];

for z = 1:length(Images)
    
    k = 1;

    for i = 1:length(Images(z).AFCY)
    
        
        for j = 0:ceil(Images(z).length_nm(i)./1000)-1;
        
            Images(z).AFCYscaled(k,:) = Images(z).AFCY(i,:);
            k = k+1;
            
        end
        
        
    end
    
    AFCYscaled = [AFCYscaled; Images(z).AFCYscaled];
    
end

AFCYscaled = AFCYscaled(2:end,:);

clear i j k z
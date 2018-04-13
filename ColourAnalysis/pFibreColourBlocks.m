nImages = length(Images);

parfor z = 1:nImages;

    disp(['Image ' num2str(z) ' of ' num2str(nImages) '.']);
    
        
        [Images(z).output] = ColourBlock(Images(z).xy_nm,Images(z).AF,Images(z).CY);
        
  
        
end       
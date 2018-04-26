function [Images] = FiberApp2Modes(Images)

numberImages = length(Images);

for img = 1:numberImages
    
    numberFibrils = length(Images(img).xy_nm);
    
    for f = 1:numberFibrils
        x = Images(img).xy_nm{f}(1,:)';%./1000;
        y = Images(img).xy_nm{f}(2,:)';%./1000;
        Images(img).modes{f} = NumericalFModes(x,y,25);
        Images(img).q{f} = (1:25)'.*pi()./(Images(img).length_nm(f));%/1000);
        q = Images(img).q{f};
        a = Images(img).modes{f}.an';
        Images(img).Ubend(f) = sum((a(q<1.2).*q(q<1.2)).^2);
        
    end
end
end
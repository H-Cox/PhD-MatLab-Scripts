function [Images] = addModefit(Images)

for im = 1:length(Images)
    for f = 1:length(Images(im).xy_nm)
        Images(im).modefit(f) = NumericalFModes(Images(im).xy_nm{f}(1,:),...
            Images(im).xy_nm{f}(2,:),25);
end
end

end
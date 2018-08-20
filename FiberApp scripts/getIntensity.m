function [pixelIntensities] = getIntensity(image,pixelCoords)

pixelCoords = ceil(pixelCoords);

for c = 1:size(pixelCoords,2)
    
    pixelIntensities(c) = image(pixelCoords(2,c),pixelCoords(1,c));
    
end
end

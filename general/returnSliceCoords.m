function [sliceXY] = returnSliceCoords(xypt,angle,len,npts)

% Function to generate xy co-ordinates for a line of length len with an
% angle of angle centred at the point xypt.

runX = cos(angle)*len/2;
runY = sin(angle)*len/2;

sliceX = linspace(xypt(1)-runX,xypt(1)+runX,npts);
sliceY = linspace(xypt(2)-runY,xypt(2)+runY,npts);

sliceXY = [sliceX',sliceY'];

end
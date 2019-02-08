function [rG, eigen] = radiusGyration(gyrationTensor)

eigen = eig(gyrationTensor);

rG = sqrt(sum(eigen));

end
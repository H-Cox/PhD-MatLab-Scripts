% Written by Henry Cox (05/10/17) to calculate a 2D gaussian for x and y
% defined by xy and settings defined by settings.

function [z] = Gaussian2D(settings,xy)
    
    % settings = [constant, x0,y0,sigmax,sigmay]
    z = settings(1).*exp(-((xy(:,:,1)-settings(2)).^2./(2.*settings(3).^2)...
        +(xy(:,:,2)-settings(4)).^2./(2.*settings(5).^2)));
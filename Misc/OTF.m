function [points] = OTF(Kperp, k)

k = abs(k);

points = 2./pi().*(acos(k./Kperp)-k./Kperp.*sqrt(1-(k./Kperp).^2));

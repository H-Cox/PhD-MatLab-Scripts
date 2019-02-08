function [points] = PSF(Kperp, p)

C = pi().*Kperp.^2./4;

points = C.*(besselj(1,pi().*Kperp.*p)./(pi().*Kperp.*p)).^2;

end
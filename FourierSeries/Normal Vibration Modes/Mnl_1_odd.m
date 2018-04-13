function [Mnl_1] = Mnl_1_odd(n,l,L)

alpha = Mnl_alpha(l);

prefix = - cos(n*pi()/2)/cos(alpha/2);

denom = ( (pi()*n).^2-alpha^2 ) / ( L^2 );

term1 = (pi()*n/L)*sin(pi()*n/2)*sin(alpha/2) + ...
    (alpha/L)*cos(n*pi/2)*cosh(alpha/2);

term2 = (pi()*n/L)*sin(pi()*n/2)
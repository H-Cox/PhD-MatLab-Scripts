function [Theta,s] = modes_to_angle(modes,points,L)

s = linspace(0,1,points);
n = length(modes);

% calculate pi*s/L
incos2 = pi().*s;

nvals = (1:n)';

% calculate new tangent, Theta
for i = 1:length(s)
    Theta(i) = sqrt(2/L)*sum(modes.*cos(nvals.*incos2(i)));
end
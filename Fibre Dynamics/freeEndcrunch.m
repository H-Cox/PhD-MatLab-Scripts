function [yfit] = freeEndcrunch(parameters,s)

shift = parameters(1);
error = parameters(2);
Lp = parameters(3);

if abs(shift) > 100
    shift = abs(shift)*100/shift;
end


s = s + shift;


yfit = s.^3./(3.*Lp) + error.^2;

end
% Function to calculate a value of the M matrix independent of fibril
% length.
% Written by Henry Cox 10/11/17
function [value] = LM(n,l)

% if one is odd and other is even, M = 0
if rem(n,2) ~= rem(l,2)
    value = 0;
    return
end

% calculate alpha
alpha = Mnl_alpha(l);

% calculate the value
value = -4*sqrt(2)/(1-(n*pi()/alpha)^4);

% flip sign if odd
if rem(l,2) ~= 0
    value = -value;
end
end
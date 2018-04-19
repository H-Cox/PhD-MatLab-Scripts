function [c] = overlapConcentration(Mw,factor)
% function to calculate the overlap concentration of a flexible polymer of
% molecular weight, Mw, input the factor needed for calculating the radius
% of gyration if you know it.... otherwise this may not be accurate.


% avogadros number
Na = 6.02e23;

% if the factor is not specified use the one for pNIPAM
if ~exist('factor','var')
    factor = 0.0131;
end

% calculate radius of gyration
Rg = factor*Mw^0.58;

% calculate overlap concentration in units of grams per metre cubed
c = (Mw/Na)*(4/3*pi()*(Rg*1e-9)^3)^-1;

% calculate in units of mg/ml
c = c/1000;

end
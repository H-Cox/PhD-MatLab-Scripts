function [Rg] = radiusGyration(Mw,factor)
% function to calculate the radius of gyration of a flexible polymer of
% molecular weight, Mw, input the factor needed for calculating the radius
% of gyration if you know it.... otherwise this may not be accurate.

% if the factor is not specified use the one for pNIPAM
if ~exist('factor','var')
    factor = 0.0131;
end

% calculate radius of gyration in nm
Rg = factor*Mw^0.58;
end
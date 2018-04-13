function [G,r] = get_autocorr1D(I1 , mask, rmax, flag)
% function [G, r, g, dg, mask] = get_autocorr(I1 , mask, rmax, flag)
% calculates autocorrelation function for two dimensional images
%
% INPUTS
% I1 = image to be autocorrelated
% mask = region of interest, If none or [] specificed, user will be asked
%   to define.  To autocorreate the entire images, use mask = ones(size(I1))
% rmax = maximum r value to correlate in units of pixels. default is 100;
% flag = display flag.  insert 1 to display errorbar(r, g, dg) after
%   computation.
%
% OUTPUTS
% G = two dimensional correlation function.  x and y values range between
%    -rmax:rmax
% r = radius values
% g = angularly averaged autocorrelation function.
% dg = errors on angularly averaged g
% mask = masked used for calculation
%
% NOTE: G(r=0) is just the dot product of the image.  For display purposes,
% G(r=0) is set to zero in the 2D autocorrelation output.  g(r=0) [g(1)]
% retains the proper value.
%
% Last updated 01.26.10 by Sarah Veatch.



if nargin<4, flag = 0; end  % flag for display
if (nargin<3 || isempty(rmax)), rmax=100; end  % distance of maximum correlation recorded
if (nargin<2 || isempty(mask)),    %% draw a mask if needed
    imagesc(I1); axis equal tight off;
    mask = roipoly;
end

%mask = ones(size(I1)); end

N = sum(sum(I1.*mask));  % number of particles within mask
A = sum(sum(mask));      % area of mask

I1 = double(I1);         % convert to double

L1 = length(I1)+rmax; % size of fft (for zero padding)

NP = real(fftshift(ifft(abs(fft(mask, L1)).^2))); % Normalization for correct boundary conditions
G1 = A^2/N^2*real(fftshift(ifft(abs(fft(I1.*mask,L1)).^2)))./NP; % 2D G(r) with proper normalization
G = G1(floor(L1/2+1):floor(L1/2+1)+rmax);  %only return valid part of G

r = 0:rmax;

G(rmax+1) = 0;

if flag,
    
    plot(r(2:length(r)), G(2:length(r)));
    axis tight
end
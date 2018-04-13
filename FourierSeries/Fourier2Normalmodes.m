function [b] = Fourier2Normalmodes(varargin)

% import variables
a = varargin{1};
L = varargin{2};
nmax = size(a,1);

% import lmax or determine it
if length(varargin) == 3
    lmax = varargin{3};
else
    lmax = nmax;
end

% Generate M and calculate inverse
M = GenerateM(nmax,lmax)./L;
InvM = pinv(M);

% loop and calculate the normal modes
for l = 1:lmax 
    b(l,:) = InvM(l,l:end)*a(l:end,:);
end

end







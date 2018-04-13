% generates the matrix M, independent of fourier length. Inputs can be
% nothing or nmax,lmax, the max number of modes required.
% Written by Henry Cox 10/11/17
function [M] = GenerateM(varargin)

% check for inputs and if there are none revert to defaults
if length(varargin) == 2
    nmax = varargin{1};
    lmax = varargin{2};
else
    nmax = 25;
    lmax = 10;
end

% initiate M
M = zeros([nmax,lmax]);

% loop and calculate M
for n = 1:nmax
    for l = 1:lmax
        M(n,l) = LM(n,l);
    end
end
end
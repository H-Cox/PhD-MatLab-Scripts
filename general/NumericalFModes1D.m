% Given the data in x and y (must be same length), calculate the fourier
% modes (0,1,...,n) to describe the shape of (x,y).
% Written by Henry Cox, 01/11/17

function [modefit] = NumericalFModes1D(y,n)

% check dimensions are the right way around
if size(y,1) == 1
    y = y';
end

x = 1:length(y);
x = x';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% find the scalar, s, distance along the contour described by (x,y)
dx = diff(x);
dy = diff(y);
ds = sqrt(dx.^2+dy.^2);
s = 0;
for k = 1: length(ds)
    s = [s; sum(ds(1:k))];
end

% find the midpoint of each segment on the contour
smid = s(1:end-1) + (s(2:end)-s(1:end-1))./2;

% find the length of the contour
L = s(end);

% find the tangent angle at each point on the contour
tangent = y(2:end);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% start calculating the fourier modes
% an = sqrt(2/L)*sum(tangent*s*cos((n*pi*smid)/L))

% first calculate tangent*ds
TS = tangent.*ds;

% calculate inside of cos term
incos = pi().*smid./L;

% finally calculate an
for i = 1:n
    an(i) = sqrt(2/L)*sum(TS.*cos(i.*incos));
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% now reverse the calculation to generate the tangent angles to evaluate
% the fitting
% Theta(s) = sum(Thetan(s))
% Thetan(s) = sqrt(2/L)*an*cos(n*pi*s/L)

% calculate pi*s/L
%incos2 = pi().*s./L;
incos2 = pi().*linspace(0,1,100);
nvals = 1:n;

% calculate new tangent, Theta
for i = 1:length(incos2)
    Theta(i) = sqrt(2/L)*sum(an.*cos(nvals.*incos2(i)));
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% output everything
modefit.an = an;
modefit.L = L;
modefit.s = s;
modefit.tangents = tangent;
modefit.Theta = Theta';
modefit.smid = smid;
end


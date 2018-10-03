% Given the data in x and y (must be same length), calculate the fourier
% modes (0,1,...,n) to describe the shape of (x,y).
% Written by Henry Cox, 01/11/17

function [modefit] = NumericalFModes(x,y,n)

% check dimensions are the right way around
if size(x,1) == 1
    x = x';
end
if size(y,1) == 1
    y = y';
end

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
tangent = atan(dy./dx);

if max(abs(diff(tangent))) > 1
    tangent = tangentClean(tangent);
end

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
incos2 = pi().*linspace(0,1,length(tangent));
nvals = 1:n;

% calculate new tangent, Theta and curvature.
for i = 1:length(incos2)
    Theta(i) = sqrt(2/L)*sum(an.*cos(nvals.*incos2(i)));
    Curvature(i) = sqrt(2/L)*sum(an.*nvals.*(pi()/L).*sin(nvals.*incos2(i)));
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% output everything
modefit.an = an;
modefit.L = L;
modefit.s = s;
modefit.tangents = tangent;
modefit.Theta = Theta';
modefit.Curvature = Curvature';
modefit.smid = smid;
modefit.error = FindError(tangent,Theta);
end


function [error] = FindError(tangent,Theta)

t = tangent-mean(tangent);
at = t - Theta';
at2 = at.^2;
error = sum(at2);
end

function [tangent] = tangentClean(tangent)

dt = diff(tangent);
ind = find(abs(dt)>1);
for s = 1:length(ind)
    %hold on; plot(tangent)
    tangent(ind(s)+1:end) = tangent(ind(s)+1:end)-pi()*dt(ind(s))/abs(dt(ind(s)));
end
%figure; plot(tangent)
end


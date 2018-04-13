% calculates Howard Fourier Components for a fibre, set n for the number of
% fourier components you need (zeroth order to nth order), high frequency
% terms required if persistence length is less than contour length.

function [an, s, L] = HowardFourierComponents(data,n)

% input x and y points
xpts = data(:,1);
ypts = data(:,2);
%{
xpts = 1:0.1:10;
xpts = xpts';
xpts(3:7) = [];
xpts(end-10:end-3)=[];
xpts(24:34) = [];
ypts = sin(xpts.*pi()./4);
%ypts = ypts';

%}

if length(n) == 1
    n = 0:n;
    n=n';
end

% calculate the difference between points
dx = diff(xpts);
dy = diff(ypts);

% calculate distance along fibre between points and contour length
ds = sqrt(dx.^2+dy.^2);
L = sum(ds);

% calculate tangent angle at each point
theta = atan(dy./dx);

% deltas_mid factor
s_mid(1) = ds(1)./2;
s(1) = 0;

% find number of points to sum over
N = length(ds);

% calculate the s_mid and s as a function of k
for k = 2:N
    
    s_mid(k) = sum(ds(1:k-1))+ds(k)./2;
    s(k) = s(k-1)+ds(k-1);
end
s(N+1) = s(N) + ds(N);
% transpose variables
s = s';
s_mid = s_mid';

% set up k variable for summing
k = 1:N-1;

% determine first component of an
a1 = sqrt(2/L).*theta(k).*ds(k);

% generate component for inside cosine, has dimensions (n,k)
ns_mid = repmat(n,[1,length(s_mid)]);
ns_mid = bsxfun(@times, ns_mid, s_mid');

% calculate cosine term
cosns_mid = cos(ns_mid.*pi()./(L));

% calculate s and k dependence of main an term
acos = bsxfun(@times,cosns_mid(:,k),a1');

% multiply by final factor
ank = sqrt(2/L).*acos;

% sum over k to find an
an = sum(ank,2);

clear ank cosns_mis ns_mid a1 k s_mid ds dy dx xpts ypts

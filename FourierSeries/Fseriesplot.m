function [a,b,yfit] = Fseriesplot(varargin)

% check inputs
if length(varargin) < 3
    modes = 5; 
else
    modes = varargin{3};
end

if length(varargin) < 4
    nodepos = 0; 
else
    nodepos = varargin{4};
end

Y = varargin{2};
% number of frames
[m,n] = size(Y);

% if there is no defined X then generate it
if length(varargin{1}) == 1
    X = 1:m;
    X = X';
    X = repmat(X,[1,n]);
else
    X = varargin{1};
    X(X==0) = NaN;
end

x1 = min(X(:))+nodepos;
x2 = max(X(:))+nodepos;

X = pi*(2*(X-x1)/(x2-x1) - 1)/2;
%Y = (2*(Y-x1)/(x2-x1) - 1);

for i = 1:n
    
    xeval = X(:,i);
    yeval = Y(:,i);
    [a(:,i),b(:,i),yft(:,i)] = Fseries(xeval,yeval,modes,false,'sin');

end

figure

for i=1:modes
    hold on
    plot(a(i+1,5:end-5))
    plot(b(i,5:end-5))
    
end

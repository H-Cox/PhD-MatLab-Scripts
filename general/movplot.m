function movplot(varargin)
figure
if length(varargin) == 1
    X = 1:length(varargin{1}(:,1));
    X = repmat(X',[1,length(varargin{1}(1,:))]);
    Y = varargin{1};
    wait = 0.1;
elseif length(varargin) == 2
    X = varargin{1};
    Y = varargin{2};
    wait = 0.1;
else
    X = varargin{1};
    Y = varargin{2};
    wait = varargin{3};
end

X(X==0) = NaN;
Y(Y==0) = NaN;

minx = min(X(:));
miny = min(Y(:));
maxx = max(X(:));
maxy = max(Y(:));

n = size(X,2);

for i=1:n
    plot(X(:,i),Y(:,i))
    axis([minx maxx miny maxy])
    pause(wait)
end
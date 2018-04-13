function [c] = JFilamentperpm2(Frames,PP)

[xfn,yfn] = JFilamentinterp2(Frames,1);
xpts = PP(:,3);
ypts = PP(:,4);

xfn(xfn==0) = NaN;
yfn(yfn==0) = NaN;

% Find tangent angles along the primpath
% find dx, dy
dx = diff(xpts);
dy = diff(ypts);

% calculate tangent angle at each point
theta = atan(dy./dx);
theta(end+1) = theta(end);

c = zeros(length(xpts),size(xfn,2));

% for each point, transform so that tangent is along x axis
for i = 1:length(xpts)
    
    x1 = (xfn-xpts(i))*cos(theta(i))+(yfn-ypts(i))*sin(theta(i));
    y1 = -(xfn-xpts(i))*sin(theta(i))+(yfn-ypts(i))*cos(theta(i));
    %{
    xu = unique(x1);
    
    [~,I] = sort(abs(xu));
    xu = xu(I);
    tol = 0.1;
    
    % slow method to find repeats but it works
    for xt = 1:length(xu)
        if nnz(x1==xu(xt)) > 1
            x1(x1==xu(xt)) = NaN;
            break
        end
        if abs(xu(xt)) > tol
            dx = diff(x1);
            if max(abs(dx(:))) < 1
                break
            else
                tol = tol + 0.1;
            end
        end
    end
    %}
    
    % sort to find closest points to line
    [~,I] = sort(abs(x1));
    
    x1a = zeros(size(x1));
    y1a = zeros(size(y1));
    
    for j = 1:size(x1,2)
        x1a(:,j) = x1(I(:,j),j);
        y1a(:,j) = y1(I(:,j),j);
    end
    
    xt(i,:) = x1a(1,:).*x1a(2,:);
    
    m = (y1a(2,:)-y1a(1,:))./(x1a(2,:)-x1a(1,:));
    c(i,:) = y1a(1,:)-m.*x1a(1,:);
    
end
c(xt>=0) = NaN;
point_nans = sum(isnan(c),2);
c(point_nans > 0.9*size(xfn,2),:) = NaN;
end

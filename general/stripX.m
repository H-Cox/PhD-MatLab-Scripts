function [x,y] = stripX(x,y,xlims)

y = y(x>=xlims(1),:);
x = x(x>=xlims(1));

y = y(x<=xlims(2),:);
x = x(x<=xlims(2));

end
function [q,p] = check_plateaus(q,p)

c = -8.192212235183703;
m = -5.584803004545409;

y = exp(c).*q.^(m);
yp = y-p;
index = yp > 0;
q(index) = [];
p(index) = [];

end

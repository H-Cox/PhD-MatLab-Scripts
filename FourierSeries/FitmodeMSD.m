function [fit] = FitmodeMSD(tau,m)

modelfun = @(b,x)(b(1).*(1-exp(b(2).*x)));

n = size(m,2);

for i = 1:n
    
    fit(i) = nlinfit2(tau,m(:,i),modelfun);
end
end


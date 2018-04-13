clear f terms Ank Bnk An Bn v1 tau i j k
j = 3:1000;

kn = 0.1;
mtot = 0.04;
kplus = 1.2;
nc = 3;

v1 = kn.*(mtot.^(nc-2))./(2.*kplus);
tau = 2.*atan(tanh(9e10))./sqrt(v1);

for i = j
    
    [An,Bn] = AnBn(i-2,v1);
    clear terms
    for k = 0:i-2
        
        [Ank,Bnk] = AnBn(i-2-k,v1);
        
        terms(k+1) = Bnk.*(tau.^k)./factorial(k);
    end
    
    f(i-min(j)+1) = An - exp(-tau).*sum(terms);

end

plot(j,f)
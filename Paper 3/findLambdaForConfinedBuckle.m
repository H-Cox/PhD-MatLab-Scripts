function [lambda] = findLambdaForConfinedBuckle(modulus,Lp,T)

if ~exist('T','var')
    T = 313.15;
end

kT = T*1.38e-23;

bendingStiffness = Lp*kT;

k_Alpha4 = bendingStiffness/modulus;

lambda = 2*pi()*(k_Alpha4.^0.25);

end

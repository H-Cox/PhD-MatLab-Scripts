function [force] = findForceForConfinedBuckle(modulus,Lp,T)

if ~exist('T','var')
    T = 313.15;
end

kT = T*1.38e-23;

bendingStiffness = Lp*kT;

force = 2*sqrt(bendingStiffness*modulus);

end

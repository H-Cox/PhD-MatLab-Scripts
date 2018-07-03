function [hydrodynamicRadius] = findHydrodynamicRadius(MSDGradient,temp)

	T = temp;
	k = 1.38e-23;
	kT =k*T;
	waterViscosity = 1.002e-3;
	DiffCoeff = exp(MSDGradient(1))./4;
        
	hydrodynamicRadius = kT./(6*pi()*waterViscosity*DiffCoeff);
        
	eDC = DiffCoeff.*MSDGradient(2);
	eHR = kT.*eDC./(6*pi()*waterViscosity*DiffCoeff.^2);
        
	hydrodynamicRadius(1,2) = eHR;
        
end
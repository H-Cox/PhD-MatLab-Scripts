function [hydrodynamicRadius] = findHydrodynamicRadius(MSDGradient,temp)

	T = temp;
	k = 1.38e-23;
	kT =k*T;
	waterViscosity = 1.002e-3;
    if size(MSDGradient,2) == 1
        diffCoeff = exp(MSDGradient(1))./4;
        
        hydrodynamicRadius = kT./(6*pi()*waterViscosity*diffCoeff);
        
        eDC = diffCoeff.*MSDGradient(2);
        eHR = kT.*eDC./(6*pi()*waterViscosity*diffCoeff.^2);
        
        hydrodynamicRadius(1,2) = eHR;
        
    else
        diffCoeff = MSDGradient;
        
        hydrodynamicRadius(1,:) = kT./(6*pi()*waterViscosity*diffCoeff(1,:));
        
        hydrodynamicRadius(2,:) = diffCoeff(2,:).*hydrodynamicRadius./diffCoeff(1,:);
    end
end
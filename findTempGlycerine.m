function [temp] = findTempGlycerine(viscosity)
warning('Off')
func = @(b,x)(returnVisc(b(1),x));

fit = nlinfit2([1],[viscosity],func);

temp = fit.xo(1,1);
warning('On')
end


function [visc] = returnVisc(temp,x)

[~, visc] = density_viscosity_glycerine_mix(1,temp);

end

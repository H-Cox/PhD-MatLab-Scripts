function [energy] = fibrilBendEnergy(parameters,x)

% find the bending energy given parameters and legnths of fibrils, x

beta = parameters(1);
U0 = parameters(2);

energy = (U0.^(1/beta).*beta).^-1 .* exp(-(x./U0).^(1/beta)) ./ x.^((beta-1)/beta);

end
% given a set of Howard Fourier Components, an, n and s it reconstructs the
% tangent angle theta(s) along the fibre.

clear ns cosns acos thetan thetas

ns = repmat(n,[1,length(s)]);

ns = bsxfun(@times, ns, s');

cosns = cos(ns.*pi()./L);

%an(1) = an(1).*2;

acos = bsxfun(@times,cosns,an);

thetan = acos;

thetas = sum(thetan);

clear ns cosns acos thetan
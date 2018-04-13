% Import data and do the fourier decomposition of all frames
%FourierDecompose

%plotfmodes(a)

% Calculate the msd for each mode
[m] = FMode2MSD(a,1);

% Find the plateau values for each msd
[plateaus] = MSDPlateau(m);

% Define function to fit to plateau values
fun = @(b,x)(b(1).*x.^-2);
y = plateaus(:,1);

n = 1:size(a,1);
q = n.*pi()./Lcval;
%{
% fit the first 6 modes and plot
[fit] = nlinfit2(q(1:5),y(1:5),fun);
Fmodeplatplot(q,y,fit.yfit)

Lp = 2/fit.xo(1);
%}
% function to calculate the mean square displacement of different fourier
% mode amplitudes. Modes should be a matrix with each mode on a row and
% each measurement of the mode (i.e. Frame) as columns. Input can be just
% modes or modes and 0 or 1 to specify if you want the result plotted
% automatically (default is 0)
% written by Henry Cox 02/11/17

function [msds] = FMode2MSD(varargin)
% import modes
modes = varargin{1};
% set plotonoff depending on if it is specified
if length(varargin) == 1
    plotonoff = 0;
else
    plotonoff = varargin{2};
end

% determine number of modes, n, and number of measurements, m
[n,m] = size(modes);

% loop through the modes and calculate the msd
for i = 1:n
    msds(:,i) = simpleMSD(modes(i,:)');
end

% plot if desired
if plotonoff == 1
    % define time points for plotting
    tau1=1:m;
    tau=tau1./100;
    tau=tau';
        
    FmodeMSDplot(tau, msds(:,:))
    
end
end



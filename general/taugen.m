function [tau] = taugen(varargin)

if length(varargin)<2
    
    fps=input('Please enter the frame rate');

    frames=input('Please enter the number of frames');
else
    fps = varargin{1};
    frames = varargin{2};
end

tau1=1:frames;

tau=tau1./fps;

tau=tau';

clear fps frames tau1
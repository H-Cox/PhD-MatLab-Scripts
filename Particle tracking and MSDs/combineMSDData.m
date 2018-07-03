function [combinedData] = combineMSDData(varargin)

if length(varargin)==1
    combinedData = varargin{1};
else
    for d = 2:length(varargin)
        varargin{1}.tr = [varargin{1}.tr, varargin{d}.tr];
    end
    
    combinedData = processPolyParticleTracks(varargin{1}.tr,varargin{1}.framerate,varargin{1}.pixelsize);
    
    
end

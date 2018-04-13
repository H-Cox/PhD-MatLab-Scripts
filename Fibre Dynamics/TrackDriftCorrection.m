function [output] = TrackDriftCorrection(Frames,Values,Drift)

   
    
    output = Values - Drift(Frames);
end

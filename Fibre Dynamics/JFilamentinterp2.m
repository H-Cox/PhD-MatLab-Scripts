% Function to interpolate between filament tracks and then return as a
% single file for creating an image from the points. N is the interpolation
% degree, usually set so that point spacing is 10nm.

function [xfn,yfn] = JFilamentinterp2(Frames,n)
    
    if isstruct(Frames)
    
        for i = 1:length(Frames)
    
            Frames(i).xfn = interpo(Frames(i).xf,n);
            Frames(i).yfn = interpo(Frames(i).yf,n);
        
            xfn(1:length(Frames(i).xfn),i) = Frames(i).xfn;
            yfn(1:length(Frames(i).yfn),i) = Frames(i).yfn;
        end
    else
        for i = 1:max(Frames(:,3))
            
            xf = Frames(Frames(:,3)==i,1);
            yf = Frames(Frames(:,3)==i,2);
            
            xfn(1:length(xf)*(n-1)+1) = interpo(xf,n);
            yfn(1:length(yf)*(n-1)+1) = interpo(yf,n);
        end
    end
end

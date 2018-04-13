% Function to interpolate between filament tracks and then return as a
% single file for creating an image from the points. N is the interpolation
% degree, usually set so that point spacing is 10nm.

function [xfn,yfn] = JFilamentinterp(Frames,n)

    xfn = [];
    yfn = [];
    
    if isstruct(Frames)
    
        for i = 1:length(Frames)
    
            Frames(i).xfn = interpo(Frames(i).xf,n);
            Frames(i).yfn = interpo(Frames(i).yf,n);
        
            xfn = [xfn; Frames(i).xfn];
            yfn = [yfn; Frames(i).yfn];
        end
    else
        for i = min(Frames(:,3)):max(Frames(:,3))
            
            xf = Frames(Frames(:,3)==i,1);
            yf = Frames(Frames(:,3)==i,2);
            
            xfn = [xfn; interpo(xf,n)];
            yfn = [yfn; interpo(yf,n)];
        end
    end
end

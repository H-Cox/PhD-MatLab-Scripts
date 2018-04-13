
function [spts] = beziersmoothing(pts,factor)
       
        % convert to complex number and smooth
        xy = complex(pts(:,1),pts(:,2));
        sxy = smoothn(xy,factor,'robust');
        
        % recover the now smooth x and y co-ordinates
        spts = [real(sxy), imag(sxy)];
        
        %hold on
        %plot(spts(:,1),spts(:,2))
        %{
        % calculate seperation between original first point and smoothed
        % first point for bezier curve
        d = sqrt((pts(1,1)-spts(1,1)).^2+...
            (pts(1,2)-spts(1,2)).^2);
        
        
        % calculate number of bezier points from average seperation on
        % smoothed curve
        gap = mean(sqrt(diff(spts(:,1)).^2+diff(spts(:,2)).^2));
        n = ceil(d/gap);
        
            
        % calculate number of bezier points using distance along smooth
        % curve
        s = 0;
        k = 1;
        while s < d
            s = s + sqrt((spts(k,1)-spts(k+1,1)).^2+(spts(k,2)-spts(k+1,2)).^2);
            k = k + 1;
        end
        n = k;
        
        % create the control points for the bezier curves
        cp1 = [pts(1,:);spts(1,:);spts(1+n,:)];
        cp2 = [spts(end-1-n,:);spts(end,:);pts(end,:)];
        
        % calculate bezier curves for start and end of fibril
        b1 = bezier.eval(cp1,n+1);
        b2 = bezier.eval(cp2,n+1);
        
        %hold on
        %plot(b1(:,1),b1(:,2))
        %plot(b2(:,1),b2(:,2))
        
        % merge with the rest of the fibril
        spts = [b1; spts(2+n:end-2-n,:); b2];
        %{
        % plot if necessary
        figure
        plot(real(xy),imag(xy))
        hold on
        plot(spts(:,1),spts(:,2))
        %}
        %}
    end

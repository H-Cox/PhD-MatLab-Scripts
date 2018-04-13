
function [perpmotion,paramotion] = DecomposeMotion(data,direction)
% script to decompose the motion of a particle (data = [xpts,ypts]) into
% that perpendicular and parallel to a direction specificed by "direction"
% in radians.

pts = data(:,1:2);

%avgpt = mean(pts,1);

%pts = bsxfun(@minus,pts,avgpt);

r = sqrt(pts(:,1).^2+pts(:,2).^2);
ang = atan(pts(:,2)./pts(:,1));

perpmotion = r.*sin(bsxfun(@plus,-ang,direction));
paramotion = r.*cos(bsxfun(@plus,-ang,direction));
end



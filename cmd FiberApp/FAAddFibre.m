function [FA] = FAAddFibre(pts,FA)

mx = []; my = []; ms = []; mr = [];

x = pts(:,1)';
y = pts(:,2)';

% use from utility folder of FiberApp
xy = utility.distributePoints([x; y], FA.step);

FA.curIm.mask{end+1} = [mx; my; ms];
FA.curIm.xy{end+1} = xy;
FA.curIm.z{end+1} = utility.interp2D(FA.im, xy(1,:), xy(2,:), FA.zInterpMethod);

% Save fiber rectangle
FA.fibRect(:,end+1) = [min(xy,[],2); max(xy,[],2)];

% Update the line and put a selection on it
FA.fibLine(end+1) = line('XData', xy(1,:), 'YData', xy(2,:));
FA.sel = length(FA.fibLine);


% Fit fiber, if checkbox is on
%if FA.autoFit; FiberAppGUI.FitFiber(hObject, eventdata); end

end
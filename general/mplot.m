% Plot multiple data sets against the same x data e.g. mplot(x,y1,y2,y3...)
% Written by Henry Cox, 09/10/17

function mplot(varargin)
    if length(varargin)> 1
        x = varargin{1};
        figure
        for i = 2:length(varargin)
            hold on
            plot(x,varargin{i})
        end
    else
        data = varargin{1};
        [r,c] = size(data);
        figure
        for i = 2:c
            hold on
            plot(data(:,1),data(:,i))
        end
    end

end
    
function [x,y] = cellPlot(varargin)

xcells = varargin{1};
ycells = varargin{2};

if length(varargin) == 3
    errorcells = varargin{3};
end

[points] = length(ycells);


x = [];
y = [];

for p = 1:points
    
    hold on
    if exist('errorcells','var')
        errorbar(xcells',ycells',errorcells');
    else
        if length(xcells) == 1
            xf = xcells{1}';
            q = 1;
        else
            xf = xcells{p}';
            q = p;
        end
        yf = ycells{p};

        plot(xf,yf);
        %fit = linearfit(log(xf(2:20)),log(yf(1:19)));
        %a(p) = fit(1,1);
    end
    xlim([0 1]);
    
    if size(xcells{q},2) > 1
        
        xcells{q} = xcells{q}';
        
    end
    
    if size(ycells{p},2) > 1
        
        ycells{p} = ycells{p}';
        
    end
    
    x = [x; xcells{q}];
    y = [y; ycells{p}];
    
    %}
end

end
function [niceFigure] = nicePlot(x,y,options)

niceFigure = figure;

[x,y,options] = checkInput(x,y,options);

% Create axes
axes1 = axes('Parent',niceFigure);
hold(axes1,'on');

% Create multiple lines using matrix input to plot
plot1 = plot(x,y,'LineWidth',2,'Parent',axes1);
if isfield(options,'DisplayName') == 1 
    for p = 1:size(y,2)
        set(plot1(p),'DisplayName',options.DisplayName{p});
    end
end

% Create xlabel
xlabel(options.xlabel);

% Create ylabel
ylabel(options.ylabel);


xlim(axes1,options.xlim);
ylim(axes1,options.ylim);

% Set the remaining axes properties
set(axes1,'FontSize',25,'YGrid','on');

pos = get(niceFigure,'position');
set(niceFigure,'position',[pos(1:2)/4 pos(3)*3 pos(4)*2])

if isfield(options,'legend') == 1
    % Create legend
    legend1 = legend(axes1,'show');
    set(legend1,...
        'Position',[0.806368774123601 0.461785008385042 0.0947611693792241 0.46079880316582],...
        'EdgeColor',[1 1 1]);
end

if isfield(options,'filename') == 1
    saveas(niceFigure,options.filename);
end

end


function [x,y,options] = checkInput(x,y,options)

[rx,cx] = size(x);
[ry,cy] = size(y);

c = 1;

while rx ~= ry || cx ~= cy
    if (rx == 1 || cx == 1) && (ry > 1 && cy > 1)
        if rx == 1
            x = repmat(x,[ry,1]);
            x = x';
            y = y';
        else
            x = repmat(x,[1,cy]);
        end
    end
    [rx,cx] = size(x);
    [ry,cy] = size(y);
    
    c = c + 1;
    
    if c > 1000
        break
    end
    
end

if isfield(options,'xlabel') == 0
    options.xlabel = 'x axis';
end

if isfield(options,'ylabel') == 0
    options.ylabel = 'y axis';
end

if isfield(options,'xlim') == 0
    options.xlim = [-Inf Inf];
end

if isfield(options,'ylim') == 0
    options.ylim = [-Inf Inf];
end

end
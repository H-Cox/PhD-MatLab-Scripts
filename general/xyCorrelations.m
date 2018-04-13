function [correlation_data] = xyCorrelations(data1,data2)

len = min([size(data1,1),size(data2,1)]);

x1 = normalise(data1(1:len,1));
x2 = normalise(data2(1:len,1));
y1 = normalise(data1(1:len,2));
y2 = normalise(data2(1:len,2));

[correlation_data(:,1),lx] = xcorr(x1,x1,'biased');
[correlation_data(:,2),lx] = xcorr(x2,x2,'biased');
[correlation_data(:,3),lx] = xcorr(x1,x2,'biased');
[correlation_data(:,4),lx] = xcorr(x2,x1,'biased');

[correlation_data(:,5),lx] = xcorr(y1,y1,'biased');
[correlation_data(:,6),lx] = xcorr(y2,y2,'biased');
[correlation_data(:,7),lx] = xcorr(y1,y2,'biased');
[correlation_data(:,8),lx] = xcorr(y2,y1,'biased');

correlation_data = correlation_data(lx>=0,:);
lx = lx(lx>=0);

figure1 = figure;

% Create axes
axes1 = axes('Parent',figure1);
hold(axes1,'on');

% Create multiple lines using matrix input to plot
plot1 = plot(lx./100,correlation_data,'LineWidth',2,'Parent',axes1);
set(plot1(1),'DisplayName','x1.x1');
set(plot1(2),'DisplayName','x2.x2');
set(plot1(3),'DisplayName','x1.x2');
set(plot1(4),'DisplayName','x2.x1');
set(plot1(5),'DisplayName','y1.y1');
set(plot1(6),'DisplayName','y2.y2');
set(plot1(7),'DisplayName','y1.y2');
set(plot1(8),'DisplayName','y2.y1');

% Create xlabel
xlabel('Time (secs)');

% Create ylabel
ylabel('Correlation');

% Uncomment the following line to preserve the X-limits of the axes
 xlim(axes1,[0 1]);
% Set the remaining axes properties
set(axes1,'FontSize',25,'YGrid','on');
% Create legend
legend1 = legend(axes1,'show');
set(legend1,...
    'Position',[0.806368774123601 0.461785008385042 0.0947611693792241 0.46079880316582],...
    'EdgeColor',[1 1 1]);
end

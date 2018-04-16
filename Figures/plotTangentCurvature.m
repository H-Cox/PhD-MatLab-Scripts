function plotTangentCurvature(s, tangents)
%CREATEFIGURE(X1, Y1, Y2)
%  X1:  vector of x data
%  Y1:  vector of y data
%  Y2:  vector of y data

X1 = s(2:end);
Y1 = tangents(2:end);
Y2 = diff(tangents)./diff(s);
%  Auto-generated by MATLAB on 15-Jan-2018 13:42:53

% Create figure
figure1 = figure;

% Create axes
axes1 = axes('Parent',figure1);
hold(axes1,'on');

% Activate the left side of the axes
yyaxis(axes1,'left');
% Create plot
plot(X1,Y1,'LineWidth',3);

% Create ylabel
ylabel('Tangent angle');

% Set the remaining axes properties
set(axes1,'YColor',[0 0 0]);
% Activate the right side of the axes
yyaxis(axes1,'right');
% Create plot
plot(X1,Y2,'LineWidth',3);

% Create ylabel
ylabel('Curvature (radians per \mum)');

% Set the remaining axes properties
set(axes1,'YColor',[0.85 0.325 0.098]);
% Create xlabel
xlabel('Distance along fibril (\mum)');

% Set the remaining axes properties
set(axes1,'FontSize',30,'LineStyleOrderIndex',2);
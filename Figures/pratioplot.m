function pratioplot(frequency, participation_ratio)


% Create figure
figure1 = figure;

% Create axes
axes1 = axes('Parent',figure1);
hold(axes1,'on');

% Create semilogx
semilogx(frequency,participation_ratio,'MarkerFaceColor',[0 0.447058826684952 0.74117648601532],...
    'Marker','o',...
    'LineStyle','--');

% Create xlabel
xlabel('Frequency');

% Create ylabel
ylabel('Participation ratio');

% Set the remaining axes properties
set(axes1,'FontSize',20,'XMinorTick','on','XScale','log');

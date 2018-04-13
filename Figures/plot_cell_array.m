function plot_cell_array(cell_array)

[rows,cols] = size(cell_array);
n=1;
for r = 1:rows
    for c = 1:cols
        YMatrix1(n,:) = cell_array{r,c};
        names{n} = [num2str(r) ' : ' num2str(c)];
    n = n + 1;
    end
end

X1 = (1:length(cell_array{1,1})).*0.01;

figure1 = figure;

% Create axes
axes1 = axes('Parent',figure1);
hold(axes1,'on');

% Create multiple lines using matrix input to plot
plot1 = plot(X1,YMatrix1,'LineWidth',2,'Parent',axes1);
for k = 1:size(YMatrix1,1)
    set(plot1(k),'DisplayName',names{k});
end

% Create xlabel
xlabel('Lag time (s)');

% Create ylabel
ylabel('MSD (\mum^2)');

% Set the remaining axes properties
set(axes1,'FontSize',20,'YGrid','on');
% Create legend
legend1 = legend(axes1,'show');
set(legend1,...
    'Position',[0.819485658803692 0.154142592008977 0.0727002956968033 0.232658952862197],...
    'EdgeColor',[1 1 1]);
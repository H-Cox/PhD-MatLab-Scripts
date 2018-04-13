function plotfmodes(modes)
    figure1 = figure;

    % Create axes
    axes1 = axes('Parent',figure1);
    hold(axes1,'on');
    
    modemags = [];
    z = zeros(1,100);
    m = size(modes,2);
    x = linspace(0.65,1.35,m);
    for i = 1:size(modes,1)
      hold on
      plot(x,modes(i,:),'.')  
      modemags = [modemags, modes(i,:),z];
      x = x + 1;
    end
    errorbar(1:size(modes,1),mean(modes,2),std(modes'),...
        'LineStyle','None','Color','k','LineWidth',3,'Marker','o',...
        'MarkerFaceColor','k')
    
    % Create xlabel
    xlabel('Mode number');

    % Create ylabel
    ylabel('Mode amplitude (um^1^/^2)');

    % Set the remaining axes properties
    xlim(axes1,[0 size(modes,1)+1]);
    set(axes1,'FontSize',20);
    
    hold off
   
end
    
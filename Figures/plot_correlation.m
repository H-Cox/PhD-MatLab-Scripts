function plot_correlation(data,Lcval)

    [len_x,len_y] = size(data);
    
    x = linspace(0,Lcval(2),len_x);
    y = linspace(0,Lcval(1),len_y);
    
    
    surf_fig = figure;

    axes1 = axes('Parent',surf_fig);
    hold(axes1,'on');

    surf(x,y,data,'Edgecolor','None');

    view([90 -90]);
    colorbar
    axis tight 
    xlabel(['Distance along fibril 2 [\mum]']);
    ylabel(['Distance along fibril 1 [\mum]']);
    title('Transverse displacement correlation matrix');
    set(axes1,'FontSize',20);
    
end
function [potential_data,xaxis,yaxis,surf_fig] = plot_potential(transverse_data,Lc)

norm = 1;

%[transverse_data] = sort_out_transverse_data(transverse_data);

[row,~] = size(transverse_data);

xaxis = linspace(0,Lc,row);

yaxis = -0.501:0.002:0.501;
%yaxis = linspace(-0.51,0.51,103);

[PDF_data,bins] = Histogram2D(transverse_data,yaxis,0);

yaxis = bins;

potential_data = -log(PDF_data);

points = unique(potential_data);

potential_data(potential_data > points(end-1)) = points(end-1);
potential_data(isnan(potential_data)) = 1;
if norm == 1
    [potential_data] = normalise_pd(potential_data);
    
    %[potential_data,yaxis] = centralise_pd(potential_data,yaxis);
end
%{
xaxis = [xaxis, xaxis(end)+mean(diff(xaxis))];
xaxis = [xaxis, xaxis(end)+mean(diff(xaxis))];
xaxis = [xaxis, xaxis(end)+mean(diff(xaxis))];

potential_data(end+1:end+3,:) = ones(3,size(potential_data,2));
%}

[surf_fig] = do_the_plotting(yaxis,xaxis,potential_data);

end

function [transverse_data] = sort_out_transverse_data(transverse_data)

    [pts,~] = size(transverse_data);
    
    for p = 1:pts
        
        fit = FitGaussianHistogram(transverse_data(p,:),100);
        transverse_data(p,:) = transverse_data(p,:) - fit.xo(2,1);
        
    end
        

end

function [potential_data] = normalise_pd(potential_data)
    mp = min(potential_data,[],2);
    potential_data = potential_data-mp;
    map = max(potential_data,[],2);
    potential_data = bsxfun(@times,potential_data,map.^-1);
end

function [surf_fig] = do_the_plotting(yaxis,xaxis,potential_data)

    %cm = generate_surface_colors(potential_data);
    
    surf_fig = figure;

    axes1 = axes('Parent',surf_fig);
    hold(axes1,'on');

    surf(yaxis,xaxis,potential_data,'Edgecolor','None');
    
    view([90 -90]);
    colorbar
    axis tight
    xlabel('Transverse displacement [\mum]');
    ylabel('Distance along fibril [\mum]');
    title('Relative confining potential along the fibril');
    set(axes1,'FontSize',20);
    pos = get(surf_fig,'position');
    set(surf_fig,'position',[pos(1:2)/4 pos(3)*3 pos(4)*2])
    xlim([-0.5,0.5]);
end

function [colourmapping] = generate_surface_colors(potential_data)
    
    %potential_data(potential_data == 0) =+ 0.00001;

    rplat = ceil(potential_data.*999)+1;

    map = parula(1000);
    
    [row,col] = size(potential_data);
    
    colourmapping = zeros(row,col,3);
    
    for r = 1:row
        for c = 1:col
            colourmapping(r,c,:) = map(rplat(r,c),:);
        end
    end
end
   



% no longer needed used from now on


function [potential_data,new_y_axis] = centralise_pd(old_potential_data,yaxis)

    % y axis step
    step = diff(yaxis(1:2));

    % determine number points
    [pts,y] = size(old_potential_data);
    
    centre = zeros(pts,1);
    
    for p = 1:pts
        
        centre(p) = find_potential_minima(old_potential_data(p,:),yaxis);
        
    end
    
    % determine distance it needs to move
    shift = centre/step;
    maxshift = max(abs(shift));
    rmshift = round(maxshift);
    shunt = round(abs(maxshift) - shift);
    
    
    % define new potential and move it
    potential_data = ones(pts,y+2*rmshift);
    for p = 1:pts
        potential_data(p,1+shunt(p):y+shunt(p)) = old_potential_data(p,1:y);
    end

    % sort out the y axis
    ysizeup = rmshift*step;
    ymin = min(yaxis)-ysizeup;
    ymax = max(yaxis)+ysizeup;
    new_y_axis = linspace(ymin,ymax,y+2*rmshift);
end

function [centre] = find_potential_minima(data,y_data)

    % invert so it can fit easier
    data = max(data) - data;

    % find mean from gaussian
    fit = FitGaussian(y_data,data);
    centre = fit.xo(2,1);

end

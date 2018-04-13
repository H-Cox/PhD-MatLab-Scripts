function [C,Cx,Lcval,fib_idse,Cix,Lci,Ci,fib_ids] = multiselectorcorr(videos)
fibrils = 0;
for v = 1:length(videos)
    
fibrils = fibrils + length(videos{v});

end
disp(['Length of fibrils is ' num2str(fibrils)]);
% internal correlation
Ci  = [];
Cix = [];
Lci = [];
fib_ids = [];
c = 1;
for v = 1:length(videos)
        
        video = videos{v};
        
        if length(video) > 1
            [Citemp,Cixtemp,Lcvalt,fib_idst] = matrixe(video);
            Ci = [Ci,Citemp];
            Cix = [Cix, Cixtemp];
            Lci = [Lci,Lcvalt];
            fib_ids = [fib_ids,fib_idst];
            
            for f = 1:length(Citemp)
                plot_correlation(Cixtemp{f}, Lcvalt{f}, fib_idst{f},c)

            end
            clear Citemp Cixtemp Lcvalt fib_idst
        end

end


Cx = [];
C = [];
Lcval = [];
fib_idse = [];
run = 1;
c = 2;
while fibrils > 1
    disp(['Run ' num2str(run)]);
    order = randperm(length(videos));
    videos = videos(order);
    ids = [];
    for v = 1:length(videos)
        
        
        order2 = randperm(length(videos{v}));
        videos{v} = videos{v}(order2);
        ids = [ids,videos{v}(1)];
        videos{v}(1) = [];
        
    end

    disp(ids)
    idsave{run} = ids;
    [Ct,Cxt,Lcvalt,fib_idset] = matrixe(ids);
    Cx = [Cx,Cxt];
    C = [C,Ct];
    
    Lcval = [Lcval, Lcvalt];
      
    for f = 1:length(Cxt)
                plot_correlation(Cxt{f}, Lcvalt{f}, fib_idset{f},c)
                c = c+1;
    end
    fibrils = 0;
    V = length(videos);
    v = 1;
    while v <= V
    
        fibrils = fibrils + length(videos{v});
    
        if isempty(videos{v}) == 1
            videos(v) = [];
            v = v-1;
        end
        V = length(videos);
        v = v+1;
    end
    disp(['Length of fibrils is ' num2str(fibrils)]);
    run = run +1;
    if run > 100
        break
    end
end
 
%}
end


function [G,Ge] = multicorrelate(ids)
parfor id = 1:length(ids)
    [x{id},y{id}] = import(ids(id));
end
[G,Ge] = multiCorrelation(x,y);
end


function [x,y] = import(id)
disp(id)
close all
path = 'C:\Users\mbcx9hc4\Dropbox (The University of Manchester)\paper 2\Fibrils\17-10-02 2-1\s 2-1-';
path2 = 'C:\Users\mbcx9hc4\Dropbox (The University of Manchester)\paper 2\Fibrils\';
filename = [path2 num2str(id) '.mat'];
%JFilImport;
%JFilamentends
load(filename);
x = xdata;
y = ydata;
mean_angle = nanmean(tang(:));
%save([path num2str(id) '.mat']);
end

function [C,Cx,Lcval,fib_ids] = matrixe(goodid)
parfor z = 1:length(goodid)
    id = goodid(z);
    [c{z},Lcvalt(z)] = loadupc(id);
    c{z} = reform_transverse_mag(c{z},Lcvalt(z),0.1);
end

C = {};
Cx = {};

for z = 1:length(goodid)-1
    disp(['Analysis of ' num2str(z) ' with ' num2str(length(goodid)-z)]);
    l = length(C);
    for p = 1:length(goodid)-z
        [point_sep,~] = size(c{z});
        fib_ids{l+p} = [goodid(z), goodid(z+p)];
        Lcval{l+p} = [Lcvalt(z), Lcvalt(z+p)];
        [C{l+p}] = correlation_matrix([c{z}(:,1:2000);c{z+p}(:,1:2000)]);
        Cx{l+p} = C{l+p}(1:point_sep,point_sep+1:end);
    end
end


end

function [c,Lcval] = loadupc(id)
path = 'C:\Users\mbcx9hc4\Dropbox (The University of Manchester)\paper 2\Fibrils\';
load([path num2str(id) '.mat']);
if ~exist('c','var')
    FourierDecompose
    [c] = JFilamentperpm(fxdata,fydata,relax_x,relax_y);
end
end

function plot_correlation(data, Lcval, fibril_ids,c)
    path = 'C:\Users\mbcx9hc4\Dropbox (The University of Manchester)\MATLAB\18-03\21 - pics\4th try\';
    filename = [num2str(c) '- ' num2str(fibril_ids(1)) ' with ' num2str(fibril_ids(2)) '.png'];
    
    % x axis is fibril 1, y axis is fibril 2
    
    [len_x,len_y] = size(data);
    
    x = linspace(0,Lcval(1),len_x);
    y = linspace(0,Lcval(2),len_y);
    
    
    surf_fig = figure;

    axes1 = axes('Parent',surf_fig);
    hold(axes1,'on');

    surf(y,x,data,'Edgecolor','None');

    view([90 -90]);
    colorbar
    axis tight equal
    xlabel(['Distance along fibril ' num2str(fibril_ids(2)) ' [\mum]']);
    ylabel(['Distance along fibril ' num2str(fibril_ids(1)) ' [\mum]']);
    title('Transverse displacement correlation matrix');
    set(axes1,'FontSize',20);
    pos = get(surf_fig,'position');
    %set(surf_fig,'position',[pos(1:2)/4 pos(3)*3 pos(4)*2])
    saveas(surf_fig,[path filename]);
    close all
end
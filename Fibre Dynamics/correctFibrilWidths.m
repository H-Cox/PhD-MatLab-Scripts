function correctFibrilWidths(id, path)
    try
        filename = [path 'fibril' num2str(id) '.mat'];
        load(filename);
    
        fx = HenryMethod(fxdata);
        fy = HenryMethod(fydata);
    
        [fx,fy] = correctFxFy(fx,fy);
    
        c2 = JFilamentperpm(fx,fy,relax_x,relax_y);
        [data] = fit_potential(c2);
        w = data.width;
        [~,~,~,surf_fig] = plot_potential(c2,Lcval);
        saveas(surf_fig,[path 'fig_' num2str(id) '_2.jpg'],'jpg');
        close all
        save([path 'fibril' num2str(id) '.mat']);
    catch
          disp(['ERROR ON FIBRIL ' num2str(id)])
          close all
    end
end
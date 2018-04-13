function [cx,cy,figx,figy] = fibrilcorrelation(key,com,angle)

n_fib = length(key);
clear cx cy

for g = 1:n_fib
        
 
end

for f = 1:n_fib
    

    for g = 1:n_fib
        
        [tcom{g}(:,1),tcom{g}(:,2)] = RotateTransform(com{g}(:,1),com{g}(:,2),-angle(f));     
        tcom{g}(:,1) = normalise(tcom{g}(:,1));
        tcom{g}(:,2) = normalise(tcom{g}(:,2));
        
        clear lx
        len = 2990;% min([size(tcom{f},1),size(tcom{g},1)]);
        options.DisplayName{g} = [num2str(key{f}) ' vs ' num2str(key{g})];
        [cx{f}(:,g),lx] = xcorr(tcom{f}(1:len,1),tcom{g}(1:len,1),'coeff');
        [cy{f}(:,g),lx] = xcorr(tcom{f}(1:len,2),tcom{g}(1:len,2),'coeff');
    end
    cx{f} = cx{f}(lx>=0,:);
    cy{f} = cy{f}(lx>=0,:);
    lx = repmat(lx(lx>=0),[n_fib,1])';
    
    
    options.xlabel = 'Time (secs)';
    options.ylabel = 'Correlation';
    options.legend = 1;
    
    options.xlim = [0,2];
    options.filename = ['Parallel Fibril ' num2str(key{f}) ' correlation.png'];
    [figx{f}] = nicePlot(lx./100,cx{f},options);
        
    options.filename = ['Perpendicular Fibril ' num2str(key{f}) ' correlation.png'];
    figy{f} = nicePlot(lx./100,cy{f},options);
    
    options.xlim = [0,30];
    options.filename = ['Parallel xlFibril ' num2str(key{f}) ' correlation.png'];
    [~] = nicePlot(lx./100,cx{f},options);
        
    options.filename = ['Perpendicular xlFibril ' num2str(key{f}) ' correlation.png'];
    [~] = nicePlot(lx./100,cy{f},options);
    close all

end


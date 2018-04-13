function [cx, lx] = CrosslinkCorrelations(fibrilangles,key)

[~, fibrils] = size(fibrilangles);

for f = 1:fibrils
    
    a{f} = normalise(fibrilangles(:,f));
    
end

for f = 1:fibrils
    close all
    

    for g = 1:fibrils
        clear lx
        len = 2000;% min([size(tcom{f},1),size(tcom{g},1)]);
        options.DisplayName{g} = [num2str(key{f}) ' vs ' num2str(key{g})];
        [cx{f}(:,g),lx] = xcorr(a{f}(1:len,1),a{g}(1:len,1),'coeff');
        
    end
    cx{f} = cx{f}(lx>=0,:);
    lx = repmat(lx(lx>=0),[fibrils,1])';
    
    
    options.xlabel = 'Time (secs)';
    options.ylabel = 'Correlation';
    options.legend = 1;
    
    options.xlim = [0,2];
    options.filename = ['2Angle Fibril ' num2str(key{f}) ' correlation.png'];
    [~] = nicePlot(lx./100,cx{f},options);
        
    options.xlim = [0,30];
    options.filename = ['2Angle xlFibril ' num2str(key{f}) ' correlation.png'];
    [~] = nicePlot(lx./100,cx{f},options);
    
end
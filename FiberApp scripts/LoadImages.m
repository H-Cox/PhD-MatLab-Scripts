for i = 1:8
    I = imread(['2AVGs-' num2str(i-1) '.tif']);
    
    I = double(I);
    I = I./max(I(:));
    
    Images(i).rawim = I;
    
end

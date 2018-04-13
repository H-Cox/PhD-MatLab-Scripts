
function [R]=rsquared(y,yfit)

    yresid=y - yfit;

    SSresid = sum(yresid.^2);

    SStotal = (length(y)-1)*var(y);

    R= 1 - SSresid/SStotal;
    
end
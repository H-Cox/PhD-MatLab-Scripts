function [fits] = fitPDFspNIPAM(pdfData)

x = pdfData(1,:);

for p = 1:size(pdfData,1)-1

    thisPDF = pdfData(p+1,:);

    fits(p) = fitPDF(x,thisPDF);
    
end
    
end


function [fit] = fitPDF(x,thisPDF)

thisPDF = smoothn(thisPDF,1);

x = x(thisPDF>0.001);
thisPDF = thisPDF(thisPDF>0.001);

diffPDF = diff(thisPDF);

while diffPDF(1) >= 0
    
    x = x(2:end);
    thisPDF = thisPDF(2:end);
    diffPDF = diffPDF(2:end);
    
end

lin = @(b,x)(log(b(1))-b(1).*x);

fit = nlinfit2(x,log(thisPDF),lin);


end
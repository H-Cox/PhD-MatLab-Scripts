function [data] = FindCrosslinks(X1,Y1,X2,Y2)
warning('off')
[A,B,C,D] = HenryMethod(X1,X2,Y1,Y2);

[points,frames] = size(A);

model = @(b,x)(b(1)+x.*b(2)+x.^2.*b(3)+x.^3.*b(4)+x.^4.*b(5));
modelangle = @(b,x)(0*b(1)+b(2)+2*b(3)*x+3*b(4)*x^2+4*b(5)*x^3);

for f = 1:frames
  

    f1(f) = nlinfit2(A(:,f),B(:,f),model);
    f2(f) = nlinfit2(C(:,f),D(:,f),model);
    
    delta =  f1(f).xo-f2(f).xo;
    
    solutions = roots(delta(end:-1:1,1));
    
    solutions(abs(imag(solutions))>0) = [];
    
    minx = max([min(A(:,f)),min(C(:,f))]);
    maxx = min([max(A(:,f)),max(C(:,f))]);
    
    solutions(solutions>maxx) = [];
    solutions(solutions<minx) = [];
    solutions = 6.5;
    if length(solutions) ~= 1
        disp('Error, continuing with next frame.')
    else
        crosslinkpos(f,1:2) = [solutions,model(f1(f).xo(:,1),solutions)];
        fibrilangles(f,1:2) = [atan(modelangle(f1(f).xo(:,1),solutions)),atan(modelangle(f2(f).xo(:,1),solutions))];
        crosslinkangle(f) = fibrilangles(f,1)-fibrilangles(f,2);
        
    end
end

data.fibrilangles = fibrilangles;
data.f1 = f1;
data.f2 = f2;
data.clposition = crosslinkpos;
data.angle = crosslinkangle;
warning('on')
end


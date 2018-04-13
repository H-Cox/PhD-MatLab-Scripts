function [ Interpx] = interpo(x,n)
%Takes input and linearly interpolates to add points between existing
%points.

j=length(x);                    %find number of points
dx=diff(x);                     %work out difference between successive points

Interpx=zeros(1,(n*(j-1)+1));       %define output variable length


for i = n:n:((n*j)-1)             %for loop to build output 
   
   k=i/n;
    
   Interpx(i-(n-1))=x(k);           
   
   p=1;
   while p<n
   
   Interpx((i+p)-n+1)=x(k)+dx(k)*p/n;
     p=p+1;
   end
   
end

Interpx((n*(j-1)+1))=x(j);          %final point of output added
Interpx=Interpx';

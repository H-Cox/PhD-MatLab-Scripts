
function [corr,r]=Lp(data)

x=data(:,1);
y=data(:,2);

dx=diff(x);
dy=diff(y);
dr=sqrt(dx.^2+dy.^2);

adr=mean(dr);

theta=atan(dy./dx);

dr(find(isnan(theta))) = [];  %remove cases where there is no movement
theta(find(isnan(theta))) = [];  %remove cases where there is no movement

L=cumsum(dr);

Lcnt=L(end);
%%%%%%%%%%%% NEW CODE %%%%%%%%%%%%%%%

n=length(theta);
U=zeros(length(theta)-1,length(theta)-1);
U(:,:)=NaN;

for i=1:n-1;   %point i
    
    %for j=1+i:n % with point j
        
        U(i,1:length(theta(1:end-i)))=cos(theta(1:end-i)-theta(1+i:end)); %j)=cos(theta(i)-theta(j));
        R(i,1:length(theta(1:end-i)))=L(1+i:end)-L(1:end-i);%j)=L(j)-L(i);
        
    %end
end

corr=nanmean(U,2);
r=linspace(adr,Lcnt,length(corr));
r = r';

%plot(r,corr)



%%%%%%%%%%%%%%%%%%
%{
r=round(R,3);
rs=unique(round(R,3));
mask=zeros(size(U));
corr=zeros(size(rs));
%Rbins=discretize(R,rs);

for i=1:length(rs)
    
    mask(:)=NaN;                               % do not include values which don't match the mask
    mask(r==rs(i))=U(r==rs(i));                % apply mask to d
                  
        
    
    corr(i)=nanmean(nanmean(mask,2),1);  

    if rem(100*i,round(length(rs),-2))==0
        disp([num2str(100*i/round(length(rs),-2)) '% done']);
    end
    
end

plot(rs,corr);
%%%%%%%%%%%% OLD CODE %%%%%%%%%%%%%%%%
%for i=1:length(theta)-1 
%    u1u2(i,1:length(theta(1:end-i)))=cos(theta(1:end-i)-theta(1+i:end)); %u1dotu2=x1x2+y1y2 
%end
%U=nanmean(u1u2,2);
%plot(U)
%}
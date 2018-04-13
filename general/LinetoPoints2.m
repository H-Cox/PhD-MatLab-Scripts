function [data]=LinetoPoints2(unsorted)
%incomplete code%

n=size(unsorted,1);

data=unsorted;

%figure, plot(tdata(:,1),tdata(:,2));
j=100;

for i = 1:n-1;
    d=bsxfun(@minus,data(i+1:end,:),data(i,:));
    dr=sqrt(d(:,1).^2+d(:,2).^2);
    
    next=find(dr==min(dr));
    
    if size(next,1)==2
        
        
    else
            
        temp=data(next(1)+i,:);                    %pull out next point
    
    end
    
    data(next+i:end-1,:)=data(next+i+1:end,:);  %remove from dataset
    
    data(i+2:end,:)=data(i+1:end-1,:);             %shunt dataset to make room for next point
    
    data(i+1,:)=temp;                   % insert next point
    %{       
    if i/j==1;
        disp([num2str(i/10) '% done']);
        j=j+100;
    end
    %}    
end
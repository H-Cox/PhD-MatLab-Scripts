function [data]=LinetoPoints(BWImage)
%incomplete code%
f=BWImage;

%index the pixels along the line
s=find(f==1);

%determine x and y co-ordinates for each index
[y,x]=ind2sub(size(f),s);

%{
%determine x co-ordinate of each index
tdata(:,1)=ceil(s./size(f,1));

%determine y co-ordinate of each index
tdata(:,2)=rem(s,size(f,1));%%%size(f,1)-rem(s,size(f,1));

%determine number of points along the line
n=size(tdata,1);
%}

%count number of points in the skeleton
n=length(x);

data=[x,y];

%{
%figure, plot(tdata(:,1),tdata(:,2));
%j=100;
%}

%find the endpoints of the skeleton to start from
[yends,xends]=find(bwmorph(f,'endpoints'));

%place one of the ends at the start of the data set
data=[xends(1),yends(1);data];

%take account of the extra point in the counting variable
n=n+1;

%initialise counting variable
i=1;

%figure, plot(xends(1),yends(1),'*');

hold on

%loop through all points on the skeleton and sort them according to how far
%away they are from each other
while i <= n-1;
    
    %subtract all unsorted points from current point
    d=bsxfun(@minus,data(i+1:end,:),data(i,:));
    
    %find distance to all unsorted points
    dr=sqrt(d(:,1).^2+d(:,2).^2);
    
    %find index of closest point to current point
    next=find(dr==min(dr));
    
    %pull out next closest point
    temp=data(next(1)+i,:);                    
    
    %remove from original position in dataset
    data(next+i:end-1,:)=data(next+i+1:end,:);  
    
    %if the two points are the same then we need to just remove one of them
    if min(dr)==0   
        
        %place shunted data set into temp variable
        temp2=data(1:end-1,:);      
        
        clear data                
        
        %fill new dataset with the temp variable
        data=temp2;              
        
        %number of data points has reduced by one
        n=n-1;
    
    %otherwise we insert the point as the next one in line
    else
        
        %shunt dataset to make room for next point
        data(i+2:end,:)=data(i+1:end-1,:);             
    
        data(i+1,:)=temp;
        
        %hold on
        %plot(temp(1),temp(2),'*');
        
        %progress counter
        i=i+1;
    end
    %{       
    if i/j==1;
        disp([num2str(i/10) '% done']);
        j=j+100;
    end
    %}    
    
end

%{
%hold on

%plot(data(:,1),data(:,2));



    %j=0;
    while dr>3                                  %test condition
        temp=data(i+1,:);                      %save next point
        tempdr=dr;
        if i==n-1;
            data=data(1:end-1,:);
        else
            data(i+1:n-1,:)=data(i+2:end,:);    %shift data in
            data(n,:)=temp;                     %move point to end
            
        end
        
        dx=diff([data(i,1) data(i+1,1)]);
        dy=diff([data(i,2) data(i+1,2)]);
        dr=sqrt(dx.^2+dy.^2);
        %else       
        %j=0;
    end
    %}
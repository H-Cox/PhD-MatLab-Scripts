function [bs,bws]=BWMerge(fibres)


%get pixel locations for the boundaries of all objects in the segmented
%image

clear bs 
bs=bwboundaries(fibres);
%{
bs2=bwboundaries(fibres);
i=1;

for n=1:length(bs2(:,1))
    
    if length(bs2{n}(:,1))>=10
        
        bs(i)=bs2(n);
        i=i+1;
        
    end
    
end
%}
%create a labelled image and extract the labels
[lfibres,labels]=bwlabel(fibres);

for i=1:labels
    
    bws{i}=find(lfibres==i);
    
end

%clean out variable space to ensure script runs ok!
clear dist di d BB

%set s counter to 1
s=1;

%let user know how many objects have been found
disp(['Found ' num2str(labels) ' objects.']);


%if only one object is found we just need to define its bounding box 
if labels==1;
        
        BB1=min(bs{1,1}(:,1));
        BB2=min(bs{1,1}(:,2));
        BB3=max(bs{1,1}(:,1));
        BB4=max(bs{1,1}(:,2));
        temp=[BB1(1,1), BB2(1,1), BB3(1,1)-BB1(1,1), BB4(1,1)-BB2(1,1)];
        
        BB{1}=temp;
        
end

%for more than one object we now check if any of the boundary pixels of
%different objects are closer than 30pixels apart
i=1;
while i<labels                %for each object i
    
    %define distance between objects to merge them
    mindist=60;
    
    %only compare objects with those it has not yet been compared to
    j=1+i;
    
    %counter to check if a merge has been completed
    c=0;
    
    %while loop to compare with other objects, must be a while as the
    %number of other objects changes as merges are completed
    while j <= labels
        
        %clean out variable space to ensure script runs ok!
        clear d di
        
        %loop through every pixel in object i and compare with the pixels in object j 
        for k=1:size(bs{i},1)
            
            %subtract pixel k from every boundary pixel of j
            di=bsxfun(@minus,bs{j}(:,:),bs{i}(k,:));
            
            %find the associated distances using pythagoras theorem
            d(k,1:size(di,1))=sqrt(di(:,1).^2+di(:,2).^2);
            
                           
        end
        
        %set any zero values to 1000
        d(d==0)=mindist+100;
        
        %find the smallest distance between objects
        mind=min(d(:));
        
        %check if a merge is completed on this j
        e=0;
        
        %if the smallest distance meets the criterion perform a merge
        if mind<mindist
            
            %clean out variable space to ensure script runs ok!
            clear tempa tempb row col sizea sizeb sizec
            
            %identify the boundary pixel numbers which are closest, row==i,
            %col==j
            [row,col] = find(d==mind);
            
            %variable to store object numbers and associated pixel numbers
            combi(s,1:4)=[i,j,row(1),col(1)];  
            
            %copy list of boundary pixels into temporary holding variables
            tempa=bs{i};
            tempb=bs{j};
    
            %obtain size information on objects
            sizea=size(bs{i});
            sizeb=size(bs{j});
    
            %calculate size of final object
            sizec=[sizea(1)+sizeb(1),2];
            
            %{
            %%%%%%%%%%%    CODE NOT CURRENTLY IN USE    %%%%%%%%%%%
            %bs{i}=zeros(sizec+50);
            
            %r=[tempa(row(1),1),tempb(col(1),1)];
            %c=[tempa(row(1),2),tempb(col(1),2)];
                        
            %insert=[linspace(min(r),max(r),50); linspace(min(c),max(c),50)];
            %insert=insert';
            %insert=round(insert);
            %insert=[linspace(tempa(row,1):tempb(col,1),50), linspace(tempa(row,2),tempb(col,2),50)];
            %%%%%%%%%%%    CODE NOT CURRENTLY IN USE    %%%%%%%%%%%
            %}
            
            %create the new merged boundary file, placing the pixels such
            %that object i to j is located at point of closest approach
            bs{i}=[tempa(1:row(1),:);tempb(col(1)+1:end,:);tempb(1:col(1),:);tempa(row(1)+1:end,:)];
            bl(i)=size(bs{i},1);
            %define the new bounding box
            BB1=min(bs{i}(:,1));
            BB2=min(bs{i}(:,2));
            BB3=max(bs{i}(:,1));
            BB4=max(bs{i}(:,2));
        
            temp=[BB1, BB2, BB3-BB1, BB4-BB2];
        
            BB{i}=temp;
            
            %delete object j which is now part of object i
            bs(j)=[];
            
            %progress the counter c, used in the combi variable
            s=s+1;
            
            %the number of objects has reduced as a result of the merge
            labels=labels-1;
            
            %Make a bw image of the new combined object and remove the
            %merged one
            bws{i}=[bws{i};bws{j}];
            bws(j)=[];
            
            %a merge was completed so c increases and d=1
            c=c+1;
            e=1;
            
        %if no merge is completed move onto the next object
        else
            j=j+1;
        end
        
    end
    
    %if no merges completed with object i then define its bounding box
    if c==0;
        
        BB1=min(bs{i}(:,1));
        BB2=min(bs{i}(:,2));
        BB3=max(bs{i}(:,1));
        BB4=max(bs{i}(:,2));
        temp=[BB1, BB2, BB3-BB1, BB4-BB2];
        
        BB{i}=temp;
        
    end
    
    disp(['Object ' num2str(i) ' done, ' num2str(c) ' merges completed.'])
    
  i=i+1;      
end

    
%{

if size(combi,1)>0
    
    num2merge=size(combi,1);
    
    for s=1:num2merge
        tempa=bs{combi(s,1)};
        tempb=bs{combi(s,2)};
    
        sizea=size(bs{combi(s,1)});
        sizeb=size(bs{combi(s,2)});
    
        sizec=[sizea(1)+sizeb(1),2];
    
        bs{combi(s,1)}=zeros(sizec);
    
        bs{combi(s,1)}=[tempa; tempb];
        
        BB1=min(bs{combi(s,1)}(:,1));
        BB2=min(bs{combi(s,1)}(:,2));
        BB3=max(bs{combi(s,1)}(:,1));
        BB4=max(bs{combi(s,1)}(:,2));
        
        temp=[BB1, BB2, BB3-BB1, BB4-BB2];
        
        BB{combi(s,1)}=temp;
        
        bs(combi(s,2),:)=[];           %delete the now merged s,2
        
        combi(combi(:,1)==combi(s,2))=combi(s,1);
               
    end    
end
%}
clear sizea sizeb sizec temp combi d di row col num2merge s i j k BB1 BB2 BB3 BB4 temp tempa tempb
end
%plot(initialbs{1}(:,1),initialbs{1}(:,2),initialbs{2}(:,1),initialbs{2}(:,2),initialbs2{1}(:,1),initialbs2{1}(:,2))

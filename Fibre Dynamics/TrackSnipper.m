% script to remove tracks based on certain criteria

i = 1;
j = length(tr);
k = 1;
% loop which cycles through localisations until all meet the criteria
while i <= j;
    
    % determines if the current localisation has been removed or not
    change = 0;
    
    tr{i}(:,1:2) = tr{i}(:,1:2) - drift(tr{i}(:,3),1:2);
    tr{i}(:,1:2) = tr{i}(:,1:2).*130;
    
    
    % given a drift values (two columns of x,y for each frame), drift
    % correction is applied to the particle tracking data
    %
    
    % add all test criteria here as if statements
    if max(tr{i}(:,1)) > 15200;
        % record that a change has occured
        change = 1;
    end
    
    if min(tr{i}(:,1)) < 5000;
        change = 1;
    end
    
    if min(tr{i}(:,2)) < 5000;
        if max(tr{i}(:,1)) < 11000;
            change = 1;
        end
    end
    
    if max(tr{i}(:,2)) > 7000;
        % record that a change has occured
        change = 1;
    end
    
    if min(tr{i}(:,2)) < 3000;
        change = 1;
    end
    
    % if a change has not occured move onto the next localisation
    if change == 0;
        objects(k).track = tr{i}(:,:);
        k = k+1;
        i = i+1;
    else
        i = i + 1;
                
    end
    % revise the number of localisations
    j = length(tr);
    
end
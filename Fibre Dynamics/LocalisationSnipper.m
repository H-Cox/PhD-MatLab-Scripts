% script to remove localisations based on certain criteria

i = 1;
j = length(data);

% loop which cycles through localisations until all meet the criteria
while i <= j;
    
    % determines if the current localisation has been removed or not
    change = 0;
    
    % add all test criteria here as if statements
    if data(i).ynm > 7000;
        % record that a change has occured
        change = 1;
    end
    
    if data(i).ynm < 3000;
        change = 1;
    end
    
    if data(i).ynm < 4500;
        if data(i).xnm < 11000;
            change = 1;
        end
    end
    
    if data(i).xnm > 15200;
        change = 1;
    end
    
    if data(i).xnm < 5000;
        change = 1;
    end
    
    %if abs(d(i)) > 3000
    %    change = 1;
    %end
    
    % if a change has not occured move onto the next localisation
    if change == 0;
        x(i) = data(i).xnm;
        y(i) = data(i).ynm;
        i = i + 1;
    else
        % remove localisation if it meets criteria
        data(i) = [];
        %d(i) = [];
        
    end
    % revise the number of localisations
    j = length(data);
    
end
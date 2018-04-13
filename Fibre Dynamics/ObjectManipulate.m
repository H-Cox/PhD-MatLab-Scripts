% script to remove tracks based on certain criteria

i = 1;
j = length(objects);
k = 1;

% loop which cycles through localisations until all meet the criteria
while i <= j;
    
    
    % objects(i).para = objects(i).para - minp;
    %{
    
    
    for k = 1:length(objects(i).perp)
        
        objects2(i).perpmsd(k) = mean((objects2(i).perp(1:end-k)-objects2(i).perp(1+k:end)).^2);
        objects2(i).paramsd(k) = mean((objects2(i).para(1:end-k)-objects2(i).para(1+k:end)).^2);
        
        perpmsd2(k,i) = objects2(i).perpmsd(k);
        paramsd2(k,i) = objects2(i).paramsd(k);
        
        
    end
    %}   
    i = i+1;    
    %}
    
    % determines if the current localisation has been removed or not
    change = 0;
    
    minimum = min(objects(i).para);
    
    % add all test criteria here as if statements
    if minimum < 10000;
        % record that a change has occured
        change = 1;
    end
    
    % if a change has not occured move onto the next localisation
    if change == 0;
        objects3(k) = objects(i);
        ratios3(k) = ratios(i);
        k=k+1;
        i = i+1;
    else
        i = i + 1;
                
    end
    %}
end
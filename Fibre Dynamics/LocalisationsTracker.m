function [objects] = LocalisationsTracker(localisation_list)

% Enter maximum seperation of particles to be considered linked
 max_seperation = 100;

% Import list of particle positions (x,y)
remaining_localisations = localisation_list;

% Find total number of frames
total_frames = max(remaining_localisations(:,2));

% Counts through each object (aggregate)
i = 1;

% Main while loop cycles through until remaining particle list is empty
while isempty(remaining_localisations) ~= 1
    
    % Create new aggregate from first particle
    objects(i).data = remaining_localisations(1,:);
    
    % Remove first particle from list of remaining particles
    remaining_localisations(1,:) = [];
    
    % Counts through particles in the current aggregate
    j = 1;
    
    % Initially aggregate size is 1
    objects(i).size = 1;
    
    % Loops through particles in an aggregate adding those from the
    % remaining list which are closer than or equal to the maximum seperation.
    while j <= objects(i).size && objects(i).data(j,2) < total_frames
        
        next_index = find(remaining_localisations(:,2)==(objects(i).data(j,2)+1));
        
        next_frame = ...
            remaining_localisations(next_index,:);
        
        % quit loop if next frame is empty
        if isempty(next_frame) == 1
            break
        end
        
        % Calculate x and y differences between current particle and
        % remaining particles
        differences = bsxfun(@minus,next_frame(:,1:5),objects(i).data(j,1:5));
        
        % Calculate seperation from the differences
        seperations = sqrt(differences(:,3).^2+differences(:,4).^2);
        
        % Find and add particles which meet the criteria to the current
        % aggregate, quit loop if not
        minima = min(seperations);
        if minima(1) > max_seperation
            break
        end
        index = seperations == min(seperations);
        addition = next_frame(index,:);
        if length(addition(:,1))>1
            addition = addition(1,:);
        end
        
        addition(5) = 0;
        
        objects(i).data(j,5) = minima(1);
        objects(i).data = [objects(i).data; addition];
  
        
        % Remove added particles from the remaining list
        removal = find(remaining_localisations(:,1)==addition(1,1));
        remaining_localisations(removal,:) = [];
        
        % Revise the aggregate size
        objects(i).size = length(objects(i).data(:,1));
        
        % Move onto the next particle in the aggregate
        j = j + 1;
        
    end
    
    % Move onto the next aggregate once all relevant particles have been added.    
    i = i + 1;
    
end
    
        
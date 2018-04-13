function [objects] = ParticleAggregator(particle_list)

% Enter maximum seperation of particles to be considered linked
max_seperation = sqrt(2);

% Import list of particle positions (x,y)
remaining_particles = particle_list;

% Counts through each object (aggregate)
i = 1;

% Main while loop cycles through until remaining particle list is empty
while isempty(remaining_particles) ~= 1
    
    % Create new aggregate from first particle
    objects(i).xypos = remaining_particles(1,:);
    
    % Remove first particle from list of remaining particles
    remaining_particles(1,:) = [];
    
    % Counts through particles in the current aggregate
    j = 1;
    
    % Initially aggregate size is 1
    objects(i).size = 1;
    
    % Loops through particles in an aggregate adding those from the
    % remaining list which are closer than or equal to the maximum seperation.
    while j <= objects(i).size
        
        % Calculate x and y differences between current particle and
        % remaining particles
        differences = bsxfun(@minus,remaining_particles(:,:),objects(i).xypos(j,:));
        
        % Calculate seperation from the differences
        seperations = sqrt(differences(:,1).^2+differences(:,2).^2);
        
        % Find and add particles which meet the criteria to the current
        % aggregate
        indexes = seperations <= max_seperation;
        objects(i).xypos = [objects(i).xypos; remaining_particles(indexes,:)];
        
        % Remove added particles from the remaining list
        remaining_particles(indexes,:) = [];
        
        % Revise the aggregate size
        objects(i).size = length(objects(i).xypos(:,1));
        
        % Move onto the next particle in the aggregate
        j = j + 1;
        
    end
    
    % Move onto the next aggregate once all relevant particles have been added.    
    i = i + 1;
    
end
    
        
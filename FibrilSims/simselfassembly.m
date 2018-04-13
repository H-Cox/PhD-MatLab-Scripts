clear all
% number of monomers
n = 10000;
% number of time steps
T = 100;
% rate constants for nucleation, growth, loss, breakage
kn = 0.01;
kg = 1;
kl = 0.1;
kb = 0.1;
knull = 1;

% initial fibers and variables
monomers = 1:n;
fibers = [];
flengths = [];
mlengths = [];
nmonos = [];

% loop through time step
for t = 1:T;
    % display progress
    if rem(t,1000)
        disp(t)
    end
    % fibre 1
    f = 1;
    
    % if no fibres, generate them
    if length(fibers) < 1
        [fibers, monomers] = nucleation(fibers, monomers, kn);
    % otherwise start by looping through fibres 
    else
        %loop through fibres and perform action on them
        while f <= length(fibers(1,:))
            
            % growth rate is proportional to number of monomers remaining
            kg1 = kg*length(monomers);
            
            % if the fibril is 3 or less in length it can't break
            if fibrillength(fibers(:,f)) <= 3
                kb1 = 0;
            else
                kb1 = kb;
            end
            
            % determine total of rate constants
            ktot = kg1 + kl + kb1 + knull;
            
            % determine number to decide action
            c = rand();
            
            % decide if it should grow
            if c < kg1/ktot
                % grow fibre
                [nfiber, monomers] = growth(fibers(:,f), monomers);
                fibers(1:length(nfiber),f) = nfiber;
                clear nfiber
            % or perform dissociation of a monomer
            elseif c < (kl+kg1)/ktot
                % import fibre and remove zeros
                fiber = fibers(:,f);
                fiber = fiber(fiber~=0);
                
                % if length is 2 it goes to two monomers
                if length(fiber) == 2;
                    monomers = [monomers, fiber(1), fiber(2)];
                    fibers(:,f) = [];
                    f = f-1;
                else
                    % perform dissociation
                    [nfiber, monomers] = dissociation(fibers(:,f), monomers);
                end
                clear nfiber
            % or perform breakage
            elseif c < (kb1 + kl + kg1)/ktot
                % do breakage
                [fibril1, fibril2] = breakage(fibers(:,f));
                
                % merge data with the rest
                fibers(1:length(fibril1),end+1)= fibril1;
                fibers(1:length(fibril2),end+1)= fibril2;
                fibers(:,f) = [];
                clear fibril1 fibril2
            end
            % move onto the next fibre
            f = f+1;
        end
        % perform nucleation on remaining monomers
        [fibers, monomers] = nucleation(fibers, monomers, kn);
    
    end
    
    % count up the stats from this time step
    nmonos = [nmonos, length(monomers)];
    if length(fibers) >= 1;
        for i = 1:length(fibers(1,:));
                flen = fibrillength(fibers(:,i));
                flengths(i,t) = flen;
        end
        mlengths(t) = mean(flengths(:,t));
        nfibs(t) = fibrillength(flengths(:,t));
    else
        mlengths(t) = 0;
        nfibs(t) = 0;
    end
    
    
end

figure
plot(1:T,mlengths,1:T,nfibs,1:T,nmonos)
        

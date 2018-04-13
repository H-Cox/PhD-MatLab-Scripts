% Written by Henry Cox to estimate the persistence length of a fibril using
% the end 2 end method. It does this by cutting up the fibril into sections
% of different length in order to get good enough statistics to pass to the
% End2endLp.m script to perform the calculation.

function [E2ELp] = singleFibrilE2E(xypoints,fidelity)

% xypoints should be x in row 1, y in row 2

segments = size(xypoints,2);
if exist('fidelity','var')==0
    fidelity = 100;
elseif fidelity > segments-1
    disp('highest fidelity exceeded')
    fidelity = segments-1;
end


Lcs = [];
E2E = [];

for f = 1:20:fidelity
    for j = 0:f-1
        tLc = calc_Lc(xypoints(1,1+j:end-f+1+j),xypoints(2,1+j:end-f+1+j));
        eE2E = sqrt(sum((xypoints(:,1+j)-xypoints(:,end-f+1+j)).^2));

        Lcs = [Lcs, tLc];
        E2E = [E2E, eE2E];
    end
end
E2ELp = End2endLp(Lcs,E2E);
E2ELp = E2ELp(1);
end
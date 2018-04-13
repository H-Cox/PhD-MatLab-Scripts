
totalframes = 2000;
k = 1;
drift (k,:) = [rawdrift(1,2), rawdrift(1,4)];
k = k + 1;
for i = 2:length(rawdrift(:,1))
    
    lframe = floor(rawdrift(i-1,1)) + 1;
    
    uframe = floor(rawdrift(i))+1;
    
    diff = uframe - lframe;
    
    xgrad = (rawdrift(i,2)-rawdrift(i-1,2))/(rawdrift(i,1)-rawdrift(i-1,1));
    xconst = rawdrift(i,2) - xgrad.*rawdrift(i,1);
    ygrad = (rawdrift(i,4)-rawdrift(i-1,4))/(rawdrift(i,1)-rawdrift(i-1,1));
    yconst = rawdrift(i,4) - ygrad.*rawdrift(i,1);
    
    for j = 1:diff;
        drift(k,1:2) = [xgrad*k+xconst, ygrad*k+yconst];
        % drift(k,1:2) = [rawdrift(i,2), rawdrift(i,4)];
        k = k + 1;
    end
    
end

d = length(drift);

while d < totalframes
    drift(d+1,1:2) = [xgrad*(d+1)+xconst, ygrad*(d+1)+yconst];
    % drift(d,1:2) = [rawdrift(i,2), rawdrift(i,4)];
    d = d + 1;
end

clear d totalframes k xgrad ygrad xconst yconst uframe lframe j i 

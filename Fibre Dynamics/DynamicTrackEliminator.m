
tr = rawtr;
m = 3.5418;
c = -54.3766;

%rawtr = tr;
AveragePosition
n = length(rawtr);
j = 1;
d = abs(m.*avgpos(:,1)-avgpos(:,2)+c)./m;
meand = mean(d);
stdd = std(d);
dtest = d - meand - 4*stdd;
clear tr
for i = 1:n
    
    m = length(rawtr{i}(:,1));
    
    if m < 5 || m > 90 || dtest(i) > 0 || avgpos(i,2) > 120 || avgpos(i,2) < 45;
        continue
    end
    tr{j} = rawtr{i};
    j = j+1;
    
end
     
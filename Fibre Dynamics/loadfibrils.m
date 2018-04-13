clear
key = {'52','55','53','54','56','57','118','62','63','64','65','66','67','121'};
for k = 1:length(key)
    
    load(['C:\Users\mbcx9hc4\Dropbox (The University of Manchester)\paper 2\Fibrils\' num2str(key{k}) '.mat']);
    
    acom{k} = com;
    ac2{k} = c;
    aangle(k) = mean_angle;
    rangle{k} = relax_angle;
    
end

clearvars -except acom ac2 aangle rangle key

com = acom;
c = ac2;
angle = aangle;

clearvars -except com c angle rangle key
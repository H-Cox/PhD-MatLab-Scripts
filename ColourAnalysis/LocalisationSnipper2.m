% script to remove localisations based on certain criteria

maxy = 20000;
miny = 0;
maxx = 40000;
minx = 0;

dataAF(dataAF(:,2)>maxy,:) = [];
dataAF(dataAF(:,2)<miny,:) = [];

dataAF(dataAF(:,1)>maxx,:) = [];
dataAF(dataAF(:,1)<minx,:) = [];

dataCY(dataCY(:,2)>maxy,:) = [];
dataCY(dataCY(:,2)<miny,:) = [];

dataCY(dataCY(:,1)>maxx,:) = [];
dataCY(dataCY(:,1)<minx,:) = [];

clear maxy maxx miny minx
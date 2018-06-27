function [ processedData] = freqSweep( rawData )
%Creates a structure from the frequency sweep data of the rheomoeter


f=rawData(:,3);

% find the number of repeats
df = f-f(1);
repeats = length(df(df==0));
datapoints = length(f);

newSize = [datapoints/repeats,repeats];

[pD.F,pD.f] = splitAndAverage(rawData(:,3),newSize);
[pD.G,pD.g] = splitAndAverage(rawData(:,4),newSize);
[pD.G1,pD.g1] = splitAndAverage(rawData(:,5),newSize);
[pD.G2,pD.g2] = splitAndAverage(rawData(:,6),newSize);
[pD.Visc,pD.visc] = splitAndAverage(rawData(:,7),newSize);
[pD.Phase,pD.phase] = splitAndAverage(rawData(:,8),newSize);
[pD.SS,pD.ss] = splitAndAverage(rawData(:,9),newSize);
[pD.SN,pD.sn] = splitAndAverage(rawData(:,10),newSize);

%{
f = reshape(rawData(:,3),newSize);
g = reshape(rawData(:,4),newSize);
g1 = reshape(rawData(:,5),newSize);
g2 = reshape(rawData(:,6),newSize);
visc = reshape(rawData(:,7),newSize);
phase = reshape(rawData(:,8),newSize);
stress = reshape(rawData(:,9),newSize);
strain = reshape(rawData(:,10),newSize);

F = mean(f,2);
G = [mean(g,2), std(g,0,2)./sqrt(repeats)];
G1 = [mean(g1,2), std(g1,0,2)./sqrt(repeats)];
G2 = [mean(g2,2), std(g2,0,2)./sqrt(repeats)];
Visc = [mean(visc,2), std(visc,0,2)./sqrt(repeats)];
Phase = [mean(phase,2), std(phase,0,2)./sqrt(repeats)];
Stress = [mean(stress,2), std(stress,0,2)./sqrt(repeats)];
Strain = [mean(strain,2), std(strain,0,2)./sqrt(repeats)];
%}

processedData = pD;

end

function [processedData, rawData] = splitAndAverage(longRawData,newSize)

rawData = reshape(longRawData,newSize);
processedData = [mean(rawData,2), std(rawData,0,2)./sqrt(newSize(2))];
end

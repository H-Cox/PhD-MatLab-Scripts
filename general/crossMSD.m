function [MSD] = crossMSD(data1,data2)

data1length=length(data1);

if size(data1,1) ~= data1length
    data1 = data1';
end

data2length=length(data2);

if size(data2,1) ~= data2length
    data2 = data2';
end

datalength = min([data1length,data2length]);

for i = 1:datalength
    % calculate the MSD for this lag time
	MSD(i) = nanmean((data1(1+i:end,:)-data1(1:end-i,:)).*(data2(1+i:end,:)-data2(1:end-i,:)));
end

end
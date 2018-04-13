function [plateaus, MSDs] = transverse_analysis(data1,data2)

[number_pts1,number_frames1] = size(data1);

if number_pts1 > number_frames1
    data1 = data1';
    number_frames1 = number_pts1;
end

[number_pts2,number_frames2] = size(data2);

if number_pts2 > number_frames2
    data2 = data2';
    number_frames2 = number_pts2;
end

number_frames = min([number_frames1, number_frames2]);

data1 = data1(:,1:number_frames);
data2 = data2(:,1:number_frames);

MSDs = mcrossMSD(data1,data2);

[row,col] = size(MSDs);

plateaus = zeros([row,col]);

for r = 1:row
    for c = 1:col
        plateaus(r,c) = MSDPlateau(MSDs{r,c}');
    end
end
end
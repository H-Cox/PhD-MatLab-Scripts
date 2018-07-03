function [alpha] = extract_alpha(MSD_features)

a = struct2cell(MSD_features);
b = cell2mat(a(6,:,:));
alpha = permute(b,[3,2,1]);
end
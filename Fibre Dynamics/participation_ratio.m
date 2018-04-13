function [P_ratio] = participation_ratio(eigenvectors)

V = eigenvectors;



sV2 = sum(aV2);
sV4 = sum(aV4);
P_ratio = sV2.^2./(length(V).*sV4);

end
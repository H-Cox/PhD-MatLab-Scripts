function [tangents] = HowardComponents2Tangents(an,s,L)

if size(an,1) ~= 1
    an = an';
end

n = (1:length(an))-1;

npiL = n.*pi()./(2.*L);

npiLs = bsxfun(@times,repmat(npiL,[length(s),1]),s);

cosnpiLs = cos(npiLs);

acos = bsxfun(@times,cosnpiLs,an);

tangents = sqrt(2./L).*sum(acos,2);
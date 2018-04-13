function [fiber, monomers] = growth(fiber, monomers)

    m = randi(length(monomers));
    fiber = fiber(fiber~=0);
    if randi([0;1]) == 0;
        fiber = [fiber; monomers(m)];
    else
        fiber = [monomers(m); fiber];
    end
    monomers(m) = [];
end
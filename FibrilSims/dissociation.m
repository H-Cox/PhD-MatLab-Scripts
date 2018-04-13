function [fiber, monomers] = dissociation(fiber, monomers)
    fiber = fiber(fiber~=0);
    if length(fiber) < 2
        fiber = [];
    elseif length(fiber) == 2
        monomers = [monomers, fiber(1), fiber(2)];
        fiber = [];
    else
        if randi([0;1]) == 0;
            m = fiber(end);
            fiber = fiber(1:end-1);
        else
            m = fiber(1);
            fiber = fiber(2:end);
        end
        monomers = [monomers, m];
    end
end
    
function [fibers, monomers] = nucleation(fibers,monomers,kn)
    d = [];
    i = 1;
    if length(monomers) < 1;
        fibers = fibers;
        monomers = monomers;
    else
        m = monomers(randperm(length(monomers)));

        while i < length(m);
    
            if rand() < kn;
                di = [m(i);m(i+1)];
                d = [d, di];
                m(:,i:i+1) = [];
            end
            i = i + 1;
        end
        if length(fibers) > 1
            if length(d)>1
                
                for j = 1:length(d(1,:))
                    fibers(1:2,end+1) = d(1:2,j);
                end
            else
                fibers = fibers;
            end
        else
            fibers = d;
        end
    monomers = m;
    end
end

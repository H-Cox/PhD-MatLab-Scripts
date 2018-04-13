

qmin = 0.29;
qmax = 1.2;

allq = [];
allpl = [];

for p = 1:length(goodno)
    
    thisq = q{goodno(p)};
    thispl = plateaus{goodno(p)}';
    
    thispl(thisq<0.29) = [];    
    thisq(thisq<0.29) = [];
    
    thispl(thisq>1.2) = [];
    thisq(thisq>1.2) = [];
    
    allq = [allq, thisq];
    allpl = [allpl, thispl];
    
end
clear mws sws cmws
counter = 1;
for j = 1:length(Images)
    msg = 'Processing fibrils...';
    f = waitbar(0,msg);
    for i = 1:length(Images(j).xy)
        waitbar(i/length(Images(j).xy))
        inum = j;
        fnum = i;
        Tubewidths
    end

end

clear i counter f hadWarning inum j lslice means normal plotonoff theta warnId warnMsg width
JFilamentends

direc = mean(ang);

[perpmotion,paramotion] = DecomposeMotion([X,Y],direc);

for i = 1:max(Frame);
    
    perpf = perpmotion(Frame==i);%.*0.13;
    paraf = paramotion(Frame==i);%.*0.13;
    
    perps(1:size(perpf,1),i) = perpf;
    paras(1:size(paraf,1),i) = paraf;
    
    prps = bsxfun(@minus,perps,mean(perps,2));
end


x1a = randi(2,20+1,1);
x1b = randi(2,20+1,1);
x2a = expand(x1a,9);
x3a = interpo(x1a,9);

x3b = interpo(x1b,9);
x2b = expand(x1b,9);

wa = 1 + abs(wfac.*(interpo(expand(randn(500,1),1),2)));
wb = 1 + abs(wfac.*(interpo(expand(randn(500,1),1),2)));
w2 = 1 + abs(wfac.*smoothn((interpo(expand(randn(50,1),1),20)).*1,1000));

maxl = min([length(wa),length(x3a), length(w2)]);

x4a = x3a(1:maxl).*wa(1:maxl);
x4b = x3b(1:maxl).*wb(1:maxl);

x5a = x4a(1:maxl).*w2(1:maxl);
x5b = x4b(1:maxl).*w2(1:maxl);

y1 = 1:21;
y1 = y1';
y3 = interpo(y1,9);

figure
hold on
plot(y3,w2(1:maxl)-1)
plot(y1,x1a-1)
plot(y1,x1b-1)
plot(y3,x3a-1)
plot(y3,x3b-1)
plot(y3,x4a-1)
plot(y3,x4b-1)
plot(y3,x5a-1)
plot(y3,x5b-1)
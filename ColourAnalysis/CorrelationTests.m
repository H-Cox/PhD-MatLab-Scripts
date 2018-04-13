


data1 = Images(3).counts{10}(:,1);
data2 = Images(3).blockpts{10}(:,1);
data3 = Images(3).blockpts{10}(:,1);
data3(data3 == -1) = 10;

[R1,L1] = xcov(data1);
c1 = R1(L1>=0);

[R2,L2] = xcov(data2);
c2 = R2(L2>=0);

[R3,L3] = xcov(data3);
c3 = R3(L3>=0);

%{
[R1,L1] = xcov(data);
c1 = R1(L1>=0);

[R2,L2] = xcorr(data);
c2 = R2(L2>=0);

for i = 0:length(data)-1
    
    x1 = data(1+i:end);
    y1 = data(1:end-i);
    
    c3(i+1,1) = sum((x1-mean(x1)).*(y1-mean(y1)))./...
        sqrt(sum((x1-mean(x1)).^2.*(y1-mean(y1)).^2));
    
    c4(i+1,1) = mean(data(1+i:end).*data(1:end-i));
    
end


%}
c1 = c1./max(c1);
c2 = c2./max(c2);
c3 = c3./max(c3);
c4 = c4./max(c4);


hold on
plot(c1)
plot(c2)
plot(c3)
%plot(c4)
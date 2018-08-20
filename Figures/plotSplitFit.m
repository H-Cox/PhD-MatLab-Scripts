function plotSplitFit(data)

figure;
x = data(:,1);
errorbar(x,data(:,2),data(:,3))
hold on
plot(x,data(:,5:6),x,data(:,4))

set(gca, 'XScale', 'log')
set(gca, 'YScale', 'log')
xlabel('Bend Energy')
ylabel('Probability')
end

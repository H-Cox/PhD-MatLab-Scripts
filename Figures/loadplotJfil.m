

qs = [];
ps = [];
q2 = [];
p2 = [];
figure
for id = 1:length(IDs)
    load(['ID ' num2str(IDs(id)) '.mat']);
    qs = [qs, q];
    ps = [ps; plateaus];
    hold on
    plot(q,plateaus)
    q2 = [q2, q(2:end)];
    p2 = [p2; plateaus(2:end)];
end
hold off
qs = qs';
q2 = q2';
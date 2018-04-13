function [fits] = fitModeMSDs(modes,name)

warning('off')

[m] = FMode2MSD(modes(1:5,:),0);

[plateaus] = MSDPlateau(m);

try 
    msd2fit = plateaus' - m;
    
catch
    msd2fit = plateaus - m;
end

%set out the exponential models to use
single = @(b,x)(b(1).*exp(-x./b(2).^2));
double = @(b,x)(b(1).*exp(-x./b(2).^2)+b(3).*exp(-x./b(4).^2));

tau = taugen(100, 500);

figure1 = figure;

% Create axes
axes1 = axes('Parent',figure1);
hold(axes1,'on');

% Create xlabel
xlabel('lag time (s)');

% Create ylabel
ylabel('Plateau - MSD (\mum)');

% Uncomment the following line to preserve the X-limits of the axes
xlim(axes1,[0 1]);
set(axes1,'FontSize',20)

for n = 1:4
    
    fits.single{n} = nlinfit2(tau,msd2fit(1:500,n),single,[1,0.1]);
    fits.double{n} = nlinfit2(tau,msd2fit(1:500,n),double,[1,0.1,1,1]);
    
    hold on
    y = (msd2fit(1:500,n)+n*msd2fit(1,1));
    yfit = (fits.double{n}.yfit+n*msd2fit(1,1));
    plot(tau,y,fits.double{n}.x,yfit,'Parent',axes1,'LineWidth',2)
    
    fits.slife(n) = sqrt(abs(fits.single{n}.xo(2,1)));
    fits.dlife(n,1:2) = [sqrt(abs(fits.double{n}.xo(2,1))),sqrt(abs(fits.double{n}.xo(4,1)))];
end
pos = get(figure1,'position');
set(figure1,'position',[pos(1:2)/4 pos(3)*3 pos(4)*2])
if exist('name','var') == 1
    saveas(figure1,name);
end

end



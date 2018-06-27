function rplotr(varargin)

if length(varargin)>1
    for g = 1:length(varargin)
        rplotr(varargin{g});
    end
else

    rD = varargin{1};

    hold on;
    c = rand(3,1);
    c1 = c./3+2/3;

    c2 = c./3+1/3;


    %plot(rD.f,rD.g1,'Color',c1,'LineWidth',1);
    errorbar(rD.F(:,1),rD.G1(:,1),rD.G1(:,2),'Color',c,'LineWidth',2);
end
end
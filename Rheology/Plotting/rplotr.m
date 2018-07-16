function rplotr(varargin)

if length(varargin)>1
    for g = 1:length(varargin)
        rplotr(varargin{g});
    end
else
    changeColours = 1;
    
    rD = varargin{1};
    rD.x = rD.f; rD.y = rD.g1;
    plotMeanandRaw([rD.F(:,1),rD.G1],rD,changeColours);
    
    rD.x = rD.f; rD.y = rD.g2;
    plotMeanandRaw([rD.F(:,1),rD.G2],rD,changeColours);
    set(gca, 'XScale', 'log')
    set(gca, 'YScale', 'log')
end
end


function plotMeanandRaw(meanData,rawData,changeColours)

    hold on;
    
    c = rand(3,1);
    c1 = c./3+2/3;

    c2 = c./3+1/3;

    if changeColours == 1
        plot(rawData.x,rawData.y,'Color',c1,'LineWidth',1);
        errorbar(meanData(:,1),meanData(:,2),meanData(:,3),'Color',c,'LineWidth',2);
    else
        errorbar(meanData(:,1),meanData(:,2),meanData(:,3),'LineWidth',2);  
    end
end

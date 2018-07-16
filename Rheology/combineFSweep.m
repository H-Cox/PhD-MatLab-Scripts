function [combinedData] = combineFSweep(varargin)

if length(varargin)==0
    disp('no input detected');
    combinedData = [];
else
    
    [combinedData] = combineRawData(varargin);
    
    [combinedData] = createAverages(combinedData);
end

end


function [combinedData] = combineRawData(inputData)

    varargin = inputData;
    combinedData.F = varargin{1}.F;
    
    combinedData.f = [];
    combinedData.g = [];
    combinedData.g1 = [];
    combinedData.g2 = [];
    combinedData.visc = [];
    combinedData.phase = [];
    combinedData.ss = [];
    combinedData.sn = [];
    
    for d = 1:length(varargin)
           
        combinedData.f = [combinedData.f, varargin{d}.f(:,2:end-1)];
        combinedData.g = [combinedData.g, varargin{d}.g(:,2:end-1)];
        combinedData.g1 = [combinedData.g1, varargin{d}.g1(:,2:end-1)];
        combinedData.g2 = [combinedData.g2, varargin{d}.g2(:,2:end-1)];
        combinedData.visc = [combinedData.visc, varargin{d}.visc(:,2:end-1)];
        combinedData.phase = [combinedData.phase, varargin{d}.phase(:,2:end-1)];
        combinedData.ss = [combinedData.ss, varargin{d}.ss(:,2:end-1)];
        combinedData.sn = [combinedData.sn, varargin{d}.sn(:,2:end-1)];
    end
end

function [combinedData] = createAverages(combinedData)

cD = combinedData;
repeats = size(cD.g,2);

combinedData.G = [nanmean(cD.g,2), nanstd(cD.g,0,2)./sqrt(repeats)];
combinedData.G1 = [nanmean(cD.g1,2), nanstd(cD.g1,0,2)./sqrt(repeats)];
combinedData.G2 = [nanmean(cD.g2,2), nanstd(cD.g2,0,2)./sqrt(repeats)];
combinedData.Visc = [nanmean(cD.visc,2), nanstd(cD.visc,0,2)./sqrt(repeats)];
combinedData.Phase = [nanmean(cD.phase,2), nanstd(cD.phase,0,2)./sqrt(repeats)];
combinedData.SS = [nanmean(cD.ss,2), nanstd(cD.ss,0,2)./sqrt(repeats)];
combinedData.SN = [nanmean(cD.sn,2), nanstd(cD.sn,0,2)./sqrt(repeats)];

end









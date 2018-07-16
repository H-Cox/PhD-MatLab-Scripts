function [ output ] = ErrorTimes(inputArrayToTimes,inputArrayToDivide)
%ERRORADD Add and subtract numbers with errors
%   Place lists of numbers with their errors in the input and this will
%   then add and subtract them and supply the correct error.

if ~exist('inputArrayToDivide','var')
    inputArrayToDivide = [1,0];
end

mainResult = exp(sum(log(inputArrayToTimes(:,1)))-sum(log(inputArrayToDivide(:,1))));

mainError = mainResult.*sumInQuadrature([inputArrayToTimes(:,2)./inputArrayToTimes(:,1);...
    inputArrayToDivide(:,2)./inputArrayToDivide(:,1)]);

output = [mainResult, mainError];

end


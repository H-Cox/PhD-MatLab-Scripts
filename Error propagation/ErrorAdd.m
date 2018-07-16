function [ output ] = ErrorAdd(inputArrayToAdd,inputArrayToMinus)
%ERRORADD Add and subtract numbers with errors
%   Place lists of numbers with their errors in the input and this will
%   then add and subtract them and supply the correct error.

if ~exist('inputArrayToMinus','var')
    inputArrayToMinus = [0,0];
end

mainResult = sum(inputArrayToAdd(:,1))-sum(inputArrayToMinus(:,1));

mainError = sumInQuadrature([inputArrayToAdd(:,2); inputArrayToMinus(:,2)]);

output = [mainResult, mainError];

end


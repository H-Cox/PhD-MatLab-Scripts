function [data] = importLocalisations(filename)
%IMPORTFILE Import numeric data from a text file as column vectors.
%   [FRAME,XNM,YNM,SIGMANM,INTENSITYPHOTON,OFFSETPHOTON,CHI2,UNCERTAINTYNM]
%   = IMPORTFILE(FILENAME) Reads data from text file FILENAME for the
%   default selection.
%
%   [FRAME,XNM,YNM,SIGMANM,INTENSITYPHOTON,OFFSETPHOTON,CHI2,UNCERTAINTYNM]
%   = IMPORTFILE(FILENAME, STARTROW, ENDROW) Reads data from rows STARTROW
%   through ENDROW of text file FILENAME.
%
% Example:
%   [frame,xnm,ynm,sigmanm,intensityphoton,offsetphoton,chi2,uncertaintynm] = importfile('43 G.csv',2, 2772768);
%
%    See also TEXTSCAN.

% Auto-generated by MATLAB on 2018/04/16 10:01:12

%% Initialize variables.
delimiter = ',';

startRow = 2;
endRow = inf;


%% Format for each line of text:
%   column1: double (%f)
%	column2: double (%f)
%   column3: double (%f)
%	column4: double (%f)
%   column5: double (%f)
%	column6: double (%f)
%   column7: double (%f)
%	column8: double (%f)
% For more information, see the TEXTSCAN documentation.
formatSpec = '%f%f%f%f%f%f%f%f%[^\n\r]';

%% Open the text file.
fileID = fopen(filename,'r');

%% Read columns of data according to the format.
% This call is based on the structure of the file used to generate this
% code. If an error occurs for a different file, try regenerating the code
% from the Import Tool.
dataArray = textscan(fileID, formatSpec, endRow(1)-startRow(1)+1, 'Delimiter', delimiter, 'TextType', 'string', 'EmptyValue', NaN, 'HeaderLines', startRow(1)-1, 'ReturnOnError', false, 'EndOfLine', '\r\n');
for block=2:length(startRow)
    frewind(fileID);
    dataArrayBlock = textscan(fileID, formatSpec, endRow(block)-startRow(block)+1, 'Delimiter', delimiter, 'TextType', 'string', 'EmptyValue', NaN, 'HeaderLines', startRow(block)-1, 'ReturnOnError', false, 'EndOfLine', '\r\n');
    for col=1:length(dataArray)
        dataArray{col} = [dataArray{col};dataArrayBlock{col}];
    end
end

%% Close the text file.
fclose(fileID);

%% Post processing for unimportable data.
% No unimportable data rules were applied during the import, so no post
% processing code is included. To generate code which works for
% unimportable data, select unimportable cells in a file and regenerate the
% script.

%% Allocate imported array to column variable names
data.frame = dataArray{:, 1};
data.xynm = [dataArray{:, 2}, dataArray{:,3}];
data.sigmanm = dataArray{:, 4};
data.intensityphoton = dataArray{:, 5};
data.offsetphoton = dataArray{:, 6};
data.chi2 = dataArray{:, 7};
data.uncertaintynm = dataArray{:, 8};


end
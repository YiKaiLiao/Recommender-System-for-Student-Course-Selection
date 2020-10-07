% M=csvread('/media/yuren/D/104score.csv',2,0);
% M=read_mixed_csv('/media/yuren/D/104score.csv',',');
function lineArray = read_mixed_csv(fileName,delimiter)
  fid = fopen(fileName,'r','n','utf-8');   %# Open the file
  lineArray = cell(78,1);     %# Preallocate a cell array (ideally slightly
                               %#   larger than is needed)
  lineIndex = 1;               %# Index of cell to place the next line in
  nextLine = fgetl(fid);       %# Read the first line from the file
  while ~isequal(nextLine,-1)         %# Loop while not at the end of the file
    lineArray{lineIndex} = nextLine;  %# Add the line to the cell array
    lineIndex = lineIndex+1;          %# Increment the line index
    nextLine = fgetl(fid);            %# Read the next line from the file
  end
  fclose(fid);                 %# Close the file
  lineArray = lineArray(1:lineIndex-1);  %# Remove empty cells, if needed
  for iLine = 1:lineIndex-1              %# Loop over linesW
     if  ~isempty(lineArray{iLine})
        lineData = textscan(lineArray{iLine},'%s','Delimiter',delimiter);  %# Read strings
         lineData = lineData{1};              %# Remove cell encapsulation
     end                  
   
%     if strcmp(lineArray{iLine}(end),delimiter)  %# Account for when the line
%       lineData{end+1} = '';                     %#   ends with a delimiter
%     end
    lineArray(iLine,1:numel(lineData)) = lineData;  %# Overwrite line data
  end
end
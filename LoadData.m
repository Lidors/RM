% Input: 
% path         path to dat file
% time         vec size 1X2 value represnts start and end in minuts
% chNum        scalar of the number of channel number (index 0)
% chOfIntrest  channels of intrest could be sclar or vector
          
% Output:
% data       data as double varieble

function [data]=LoadData(path,time,chNum,chOfIntrest)

chNum=chNum+1;

m = memmapfile(path, 'format', 'int16' );                     % opening dat file in matlab
format compact
s=size(m.Data);
datamat = reshape( m.Data, [ chNum s(1) / chNum ] )';         % orgenizing m into a matrix...
                                                              %columns = channels rows = samples             

idx=(time(1)*60*20000:time(2)*60*20000);                      % choosing time of intrest un minutes
data = double(datamat(idx,chOfIntrest+1));

end
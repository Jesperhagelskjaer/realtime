function [par,datum] = parameter()
% The path to the cat before and after light pulse

[par] = pathFolder();                         
                           
                           
par.rezName             = 'rezFMerged'; % 'rezDMMerged.mat';  %used only for OE
par.datatype            = {'csc','nrd'};                         
par.interval            = [-50 300];

par.chs                 = {'ch',[5 6 7 8]}; %'temlate = 'tp' parameter 'all' or which template [... 2 3 ...] 

par.template            = 3;

par.useBitmVolt         = 'Y'; %change the scale from bits to Volt (Y/N) 
par.signalInverted      = 'N'; %Invert the signal -/+ (Y/N)     

par.shifted             = 14;   %correction  length for difference in TTL and maximum peak used in DSort
par.spatial             = 32;   %total channels count

%command 'nrd' csc 
par.filtertype          = {'Y','butter','bandpass',1,'nrd'}; %
par.filtering           = {300,5000,30000,6}; 

datum                   = []; %dummy variable to save nrd files

end


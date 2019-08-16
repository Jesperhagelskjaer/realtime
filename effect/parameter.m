function [par,datum] = parameter()
% The path to the cat before and after light pulse

[par] = pathFolder();                         
                           
                           
par.rezName             = 'rezFMerged'; % 'rezDMMerged.mat';  %used only for OE
par.datatype            = 'digiLynxNRD';% (digiLynxCSC/digiLynxNRD)
                                   
par.interval            = [-50 150];

par.chs                 = {'ch',[21 22 23 24]}; %'temlate = 'tp' parameter 'all' or which template [... 2 3 ...] 

par.template            = 3;

par.useBitmVolt         = 'Y'; %change the scale from bits to Volt (Y/N) 
par.signalInverted      = 'N'; %Invert the signal -/+ (Y/N)     

par.shifted             = 14;   %correction  length for difference in TTL and maximum peak used in DSort
par.spatial             = 32;   %total channels count

%command 'nrd' csc 
par.filtertype          = {'Y','butter','bandpass',1,'csc'}; %
par.filtering           = {300,5000,30000,6}; 

datum                   = []; %dummy variable to save nrd files

end


function [par] = parameter()

par.lightPath           =  'P:\AU256873\recording\2019-07-09_13-16-56\';
%par.lightPath           = 'P:\AU256873\recording\2019-05-21_10-21-44\';

par.path                = 'P:\AU256873\recording\2019-07-09_12-23-51\'; % 'openEphys' only: where raw files are

par.rezName             = 'rezFMerged'; % 'rezDMMerged.mat';  %used only for OE
par.datatype            = 'digiLynxNRD';% (digiLynxCSC/digiLynxNRD)
                                   
par.before              = 50;
par.after               = 50;

par.template_LFP        = {'ch',[29]}; %'temlate = 'tp' parameter 'all' or which template [... 2 3 ...] 
par.chs                 = [29 30 31 32]; %LFP EFFECT

par.template            = 3;

par.useBitmVolt         = 'Y'; %change the scale from bits to Volt (Y/N) 
par.signalInverted      = 'Y'; %Invert the signal -/+ (Y/N)     

par.xAxis               = [-50:50]; %-30:30

par.shifted             = 14;   %correction in index for difference in TTL and maximum peak used in DSort
par.spatial             = 32;

par.filtertype          = {'Y','butter','bandpass',1};
par.filtering           = {300,5000,30000,1};

end


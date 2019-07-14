function [par] = parameter()

par.lightPath           = 'P:\AU256873\recording\2019-07-09_13-16-56\';


par.path                = 'P:\AU256873\recording\2019-07-09_12-23-51\'; % 'openEphys' only: where raw files are
par.name                = 'nrd\12_23_51And13_28_44\';

par.rezName             = 'rezFMerged'; % 'rezDMMerged.mat';  %used only for OE
par.datatype            = 'digiLynxCSC';% (digiLynxCSC/digiLynxNRD)

par.template            = 51; %platicity change
par.lightTemplate       = 17; %platicity change

par.template_LFP        = {'ch',[29 30 31 32]}; %'temlate = 'tp' parameter 'all' or which template [... 2 3 ...] 
                                        %channels = 'ch' 'all' or write which channels [1 2 3 4] the template is defined on 
par.before              = 50;
par.after               = 50;

par.chs                 = [29 30 31 32]; %LFP EFFECT

par.useBitmVolt         = 'Y'; %change the scale from bits to Volt (Y/N) 
par.signalInverted      = 'Y'; %Invert the signal -/+ (Y/N)     


par.xAxis               = [-15:15]; %-30:30

par.shifted             = 16;   %correction in index for difference in TTL and maximum peak used in DSOrt

par.spatial             = 32;
if strcmp(par.datatype,'digiLynxCSC')
    par.e_str = '\CSC\';
else
    par.e_str = '\NRD\';
end

end


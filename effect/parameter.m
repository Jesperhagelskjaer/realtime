function [par] = parameter()

par.lightPath           = 'P:\AU256873\recording\2019-06-14-18_06';

par.path{1}             = 'P:\AU256873\recording\2019-06-23_16-44-20';
par.path{2}             = 'P:\AU256873\recording\2019-06-23_14-18-06';



par.rezName             = 'rezFinal'; % 'rezDMMerged.mat';  %used only for OE
par.datatype            = 'digiLynxCSC';% (digiLynxCSC/digiLynxNRD)

par.template            = 27; %platicity change
par.lightTemplate       = 16; %platicity change

par.template_LFP        = {'ch',[13 14 15 16]}; %'temlate = 'tp' parameter 'all' or which template [... 2 3 ...] 
                                        %channels = 'ch' 'all' or write which channels [1 2 3 4] the template is defined on 
par.before              = 50;
par.after               = 50;

par.chs                 = [13:16]; %LFP EFFECT

par.useBitmVolt         = 'Y'; %change the scale from bits to Volt (Y/N) 
par.signalInverted      = 'Y'; %Invert the signal -/+ (Y/N)     


par.spatial             = 32;
if strcmp(par.datatype,'digiLynxCSC')
    par.e_str = '\CSC\';
else
    par.e_str = '\NRD\';
end

end


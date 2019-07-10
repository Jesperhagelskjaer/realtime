function [par] = parameter()

par.path{1}             = 'P:\AU256873\recording\2019-06-23_16-44-20';
par.path{2}             = 'P:\AU256873\recording\2019-06-23_14-18-06';
par.rezName             = 'rezFinal'; % 'rezDMMerged.mat';  %used only for OE
par.spatial             = 32;
par.template            = 9; %platicity change
par.template_LFP        = 'all';        %([... 2 3 ...]'all', write number 
par.before              = 50;
par.after               = 50;
par.template            = 27;
par.chs                 = [29:32]; %

par.datatype            = 'digiLynxCSC';% (digiLynxCSC/digiLynxNRD)
par.useBitmVolt         = 'Y'; %change the scale from bits to Volt (Y/N) 
par.signalInverted      = 'Y'; %Invert the signal -/+ (Y/N)     


if strcmp(par.datatype,'digiLynxCSC')
    par.e_str = '\CSC\';
else
    par.e_str = '\NRD\';
end

end


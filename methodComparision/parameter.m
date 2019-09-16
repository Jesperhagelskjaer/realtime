function [par] = parameter()


%par.path                = 'O:\ST_Duda\Maria\MM003\2019-02-23_16-32-17';
%par.path                = 'D:\2019-02-23_16-32-17';
par.path                = 'P:\AU256873\recording\2019-05-21_10-21-44';

par.rezName             = 'rezFinal';


par.filtertype          = {'Y','butter','normal','bandpass',2}; %
par.filtering           = {300,9000,30000,6}; 


par.template_LFP        = {0,[1 2 3 4]};
par.xAxis               = [-10:40];
par.jitter              = [5];
par.useBitmVolt         = 'Y';
par.signalInverted      = 'Y';

%% binraster2psth
par.DT                  = 0.02;
par.SIGMA               = 0.1;

end


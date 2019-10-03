function [par] = parameter()


%par.path                = 'O:\ST_Duda\Maria\MM003\2019-02-23_16-32-17';
%par.path                = 'D:\2019-02-23_16-32-17';
%par.path                = 'P:\AU256873\recording\2019-05-21_10-21-44';

par.path                = 'P:\AU256873\recording\2019-05-21_10-55-05\';
par.rezName             = 'rezFinal_J';


par.filtertype          = {'Y','butter','normal','bandpass',2}; %
par.filtering           = {300,9000,30000,6}; 


par.chs                 = {0,[5 6 7 8]};
par.xAxis               = [-25:25];
par.jitter              = [15];
par.useBitmVolt         = 'Y';
par.signalInverted      = 'Y';


par.indexShift          = -15; %used with JS

%% binraster2psth
par.DT                  = 0.02;
par.SIGMA               = 0.1;

end


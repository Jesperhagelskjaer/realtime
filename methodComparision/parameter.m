function [par] = parameter()


par.path                = 'O:\ST_Duda\Maria\MM003\2019-02-23_16-32-17';
%par.path                = 'D:\2019-02-23_16-32-17';
par.rezName             = 'rezFinal';


par.filtertype          = {'Y','butter','normal','bandpass',2}; %
par.filtering           = {300,9000,30000,6}; 


par.template_LFP        = {0,[29 30 31 32]};
par.xAxis               = [-10:10];
par.jitter              = [5];

end


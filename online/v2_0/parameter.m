function [par] = parameter()

par.dataLoad = {'csc'}; %'csc' OE:openEphys, DL,NRD %normally set to nrd

par.path                  = 'P:\AU256873\recording\2019-05-21_09-39-21';
par.rezName               = 'rezF'; % 'rezDMMerged.mat';  %used only for OE
par.signalInverted        = 'N'; %normally set to 'N';
par.upload                = 'N'; %save and upload data and template to HPP
par.Template_zero         = {'N',1}; %if range below set to zero
par.useBitmVolt           = 'Y'; %normally set to 'N';%('Y'/'N')

par.filtertype            = {'Y','butter','normal','bandpass',1,'nrd'}; %
par.filtering             = {300,13000,30000,6}; %{50,13000,30000,6}; 
par.threshold             = 0.85; % NCC threshold %0.93;
par.stdFactor             = [2 1.5]; %if signal bigger than nan %;2.5; (min og max)
  
par.maxL_template         = 25;
%% To use
    
par.spatial                  = 32;
par.template                 = {11;[5 6 7 8];5}; %last is the main channel
par.cutRange                 = [-600 -600 -500 -500];


par.AllTemplate              = 'Y';

par.pTemplateBigCC           = 'Y'; %Y/N %plot the big template implanted in the signal
par.pTemplateAverageBig      = 'Y';
par.plotNCC_template         = 'Y'; %Plot the NCC template

%parameter not to change
par.sizeTemplateIntoRawData = 60; % Size of the template on the other channels
par.window  = [-6 6];




end


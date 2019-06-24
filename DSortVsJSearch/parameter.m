function [par] = parameter()

par.channels        = [5 6 7 8];
%par.path            = 'P:\AU256873\recording\2019-05-16_15-33-20\'; %"without light
par.path            = 'P:\AU256873\recording\2019-05-16_15-52-43\'; light %shift in the lightPulse
%par.path            = 'P:\AU256873\recording\2019-05-16_16-02-47\'; %light
%LFP effect before light pulse shift in the light pulse
par.recType         = 'csc'; % nrd
par.filtering       = 'n'; %n = none

par.samplesBefore       = 100;
par.samplesAfter        = 700;
par.xAxis           = -par.samplesBefore:par.samplesAfter;
par.Cumsum          = 15;
par.loadRez         = {'y','rezFinal',1}; % olddesort rezI 7 

par.jitter          = 30;
par.spatial         = 32;


end


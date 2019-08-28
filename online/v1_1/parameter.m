function [par] = parameter()

par.dataLoad = 'NRD'; % OE:openEphys, DL

%par.path = 'O:\ST_JaneM-Data\OpenEphys\JM0118_PV2\2018-03-13_17-27-32\';
%par.path = 'P:\AU256873\junkRecording\2019-03-28_09-37-32\';
par.path             = 'O:\ST_Duda\Maria\RealTime\recording\2019-08-28_10-50-55\nrd\';
par.rezName          = 'rezFinalTest'; % 'rezDMMerged.mat';  %used only for OE
par.data             = 'example.dat';         %used only for OE

par.signalInverted   = 'N';
par.SAU              = 'Y'; %save and upload data and template to HPP
par.pSmallTemplate   = 'Y';
par.useBitmVolt      = 'N'; %('Y'/'N')

par.filtertype       = {'Y','butter','bandpass',1,'nrd'}; %
par.filtering        = {300,13000,30000,6}; %{50,13000,30000,6}; 

par.voltage          = 25; 
par.jitter           = 10;
par.spatial          = 32;

par.AllTemplate      = 'Y'; %Plot average template taking from the nrd file
par.template         = 5; %
par.threshold        = 0.80;   % NCC score 0.5 collect most of them
par.WindowN          = -35;      %-35;  %abs(par.WindowN)+abs(par.WindowP)<= 17 the HPP can handle max 17 samples in length
par.WindowP          = -20;      %-20;
par.mainChannel{1}   = [17 18 19 20];% [13 14 15 16];    %templ
par.mainOne{1}       = par.mainChannel{1}(1);
par.gradVal{1}       = [-100 -100 -100 -100];



end

%legacy code

%par.filtertype = 'butter';  %filtertypes: butter,rect,ellip
%par.filType = 'bandpass';

%par.fs = 30000; %Hz of the recording (all)
%par.order = 6;
%par.fslow = 13000;        %4800;
%par.fshigh = 50;        %100 butter vs 1400 rect %300
%par.lengthrecording = par.fs*60*5;
%par.lengthGroundt = par.fs*60*5;

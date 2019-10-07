clc
clear all
close all

datum = [];

[par] = parameter();

[rez,par] = loadRez(par);

[datum] = main_load_recording(par,datum);
        
[datum] = filterMain(par,datum);

%[datum] = loadMClust(par,datum);        

[datum] = main_trace(par,rez,datum,'JSearch','dsort');%'dsort','MClust',

[datum] = correlate_main(par,datum,rez); %NCC.,NSSD
 
PCA_Mahanobilis_allCh(par,datum,'alignment','min','normalisation','none') %
%PCA_Mahanobilis_allCh('alignment','min','normalisation','minMax') %

[TE_FC] =  MakeTrialEvents_SimpleFreeChoice(par.path,'OpenEphys','\*MM_03_FreeChoiceDynMatch_Feb23_2019_Session1*');%\*FreeChoice*'
 
Quicktest4RasterPSTH_v2(par,datum,par.path,TE_FC)

%lack alignment
%isolationDistance(par,datum)

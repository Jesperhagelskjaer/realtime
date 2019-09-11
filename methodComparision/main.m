clc
clear all
close all

datum = [];

[par] = parameter();

[rez,par] = loadRez(par);

[datum] = loadOpenEphys(par,datum);

[datum] = filterMain(par,datum,'OpenEphys');

[datum] = loadMClust(par,datum);        

[datum] = main_trace(par,rez,datum,'dsort','MClust');

[datum] = correlate_DS_MC_CL(par,datum,'method','NSSD'); %NCC.,NSSD
 
[datum] = correlationSpikeTime(par,rez,datum);
 
PCA_Mahanobilis_allCh(par,datum,'C_PCA',[],'alignment','min','normalisation','minMax') %

[TE_FC] =  MakeTrialEvents_SimpleFreeChoice(par.path,'OpenEphys','\*MM_03_FreeChoiceDynMatch_Feb23_2019_Session1*');%\*FreeChoice*'
 
Quicktest4RasterPSTH_v2(par,datum,par.path,TE_FC)

%lack alignment
%isolationDistance(par,datum)

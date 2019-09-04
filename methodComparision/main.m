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

[datum] = nccComparision(par,rez,datum);

PCA_Mahanobilis_allCh(par,datum,'C_PCA',[],'alignment','min','normalisation','minMax') %


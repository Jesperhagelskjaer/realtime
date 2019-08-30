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

nccComparision(par,datum)






figure
surf(datum.template_mean_DSort{1})
figure
surf(datum.template_mean_DSort{2})
figure
surf(datum.template_mean_MClust{1})
figure
surf(datum.template_mean_MClust{2})



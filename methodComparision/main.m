clc
clear all
close all

% swt = [2 1]
% t_v(1) = 1;
% t_v(2) = 2;
% 
% b = t_v(swt)
% 
% t{1} = 1;
% t{2} = 2;
% 
% b_t = t(swt)



datum = [];

[par] = parameter();

[rez,par] = loadRez(par);

[datum] = loadOpenEphys(par,datum);

[datum] = filterMain(par,datum,'OpenEphys');

[datum] = loadMClust(par,datum);        

[datum] = main_trace(par,rez,datum,'dsort','MClust');

nccComparision(par,datum);

figure
surf(datum.template_mean_DSort{1})
figure
surf(datum.template_mean_DSort{2})
figure
surf(datum.template_mean_MClust{1})
figure
surf(datum.template_mean_MClust{2})



clear all
close all
clc

[par] = parameter();

[rez] = loadRez(par);
[par] = templateLight(par);             %take of the template used for real time classification
%plotISI(rezT); 

[RasterR1,par] = rasterMain(par,rez);   %create the raster plot

plotRasterEffectV2(par,rez,RasterR1)


%% LFP effect
% The filtering effect should be made very careful

LFP_effect(par,rez)


%gassuasianRaster(par,rezT,RasterR1)
clear all
close all
clc

[par] = parameter();

[rezT] = loadRez(par);

plotISI(rezT); 

[RasterR1] = raster_f(par,rezT);
[RasterR1] = raster_cat(par,rezT);


%plotRasterEffect(par,rezT,RasterR1)
plotRasterEffectV2(par,rezT,RasterR1)
%gassuasianRaster(par,rezT,RasterR1)

%% LFP effect
% The filtering effect should be made very careful

%LFP_effect(par,rezT)

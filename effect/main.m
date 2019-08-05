clear all
close all
clc

[par] = parameter();

[rez] = loadRez(par);
%[par] = templateLight(par);             %take of the template used for real time classification
%plotISI(rezT); 

%% plot the average waveform of JSearch and Dsort
%plot_csc_with_event(par,1)

%%

%load event for light and non-light case
[TTLs,TimestampsEvent] = loadEvent(par.path,par.e_str);
[TTLsLight,TimestampsEventLight] = loadEvent(par.lightPath,par.e_str);

% load csc files
[dataCSC,Timestamps] = main_load_csc(par,par.path);
[dataCSC_light,Timestamps_light] = main_load_csc(par,par.lightPath);

[dataTraceJ,dataJSearchF_shift,~] = TTL_data_Index(par,Timestamps,TTLs,TimestampsEvent,dataCSC);
[dataTraceJ_Light,dataJSearchF_light_shift,indexLight] = TTL_data_Index(par,Timestamps_light,TTLsLight,TimestampsEventLight,dataCSC_light);
%%

[dataTraceD,~] = traceDSort(par,rez,dataCSC);

plotTraceChannel(par,dataJSearchF_shift,dataTraceD)

plotMeanTrace(par,dataJSearchF_shift,dataTraceD)

%% PCA space

PCA_Mahanobilis(par,dataJSearchF_shift,dataTraceD,'P_part_trace')

%% plot AC AND LFP just for J

%plot_AC_TTL_LFP(par,dataTraceJ_Light)

%% Correlate DSort and JSearch

%cor_D_J(par,rez,dataCSC_light,indexLight);


%% Plot the raster of the nuerons
[RasterR1,par] = rasterMain(par,rez);   %create the raster plot
plotRasterEffectV2(par,rez,RasterR1)

%% One waveform with TTL

%plot_Interval_csc_with_event(par,dataTraceJ)

%plot_Interval_csc_with_event(par,dataTraceJ_Light)


%% LFP effect
% The filtering effect should be made very careful

%LFP_effect(par,rez)
%gassuasianRaster(par,rezT,RasterR1)

% for i =1:size(rez.M_template,3)
% wv_ccg(rez,i)
% end


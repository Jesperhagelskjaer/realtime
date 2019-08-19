clear all
close all
clc

[par,datum] = parameter();

[rez,par] = loadRez(par);
[par] = templateLight(par);             %take of the template used for real time classification
%plotISI(rezT); 

%% plot the average waveform of JSearch and Dsort
%plot_csc_with_event(par,1)

%% Load the different files

%load event for light and non-light case
[TTLs,TimestampsEvent] = loadEvent(par.path);

% load csc files load the light and the nonlight case
[datum] = main_load_csc(par,par.path,datum); %Load no light sessions

[datum] = main_load_NRD(par,datum,par.path);

%% Filtering
[datum] = filterMain(par,datum,'NRD');

%% crop the data into session of the TTL

[dataTraceJ,dataJSearchF_shift] = TTL_data_Index(par,TTLs,TimestampsEvent,datum,'type','csc');
[dataTraceJ_NRD,dataTraceJ_NRD_shift] = TTL_data_Index(par,TTLs,TimestampsEvent,datum,'type','nrd');
%% Plot trace
%[dataTraceD,~] = traceDSort(par,rez,dataCSC);

%plotTraceChannel(par,dataJSearchF_shift,dataTraceD) Plot  all

%plotMeanTrace(par,dataTraceJ,dataTraceD)
%
plotOneTrace(par,dataTraceJ,'time','ms'); %,'trace',[1 200]
plotOneTrace(par,dataTraceJ_NRD,'time','ms'); %,'trace',[1 200]
%plotTemplateDSort(rez,10)

%% PCA space

%PCA_Mahanobilis(par,dataJSearchF_shift,dataTraceD,'P_part_trace')

%% plot AC AND LFP just for J

%plot_AC_TTL_LFP(par,dataTraceJ)
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


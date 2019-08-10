clear all
close all
clc

[par] = parameter();

[rez] = loadRez(par);
[par] = templateLight(par);             %take of the template used for real time classification
%plotISI(rezT); 

%% plot the average waveform of JSearch and Dsort
%plot_csc_with_event(par,1)

%% Load the different files

%load event for light and non-light case
[TTLs,TimestampsEvent] = loadEvent(par.path,'\csc\');
[TTLsLight,TimestampsEventLight] = loadEvent(par.lightPath,'\csc\');

% load csc files load the light and the nonlight case
[dataCSC,Timestamps] = main_load_csc(par,par.path); %Load no light sessions
[dataCSC_light,Timestamps_light] = main_load_csc(par,par.lightPath); %load light session

[data] = main_load_NRD(par,par.path);

%% Filtering
[data] = filterMain(par,data,'NRD');


%% crop the data into session of the TTL

[dataTraceJ,dataJSearchF_shift,~] = TTL_data_Index(par,Timestamps,TTLs,TimestampsEvent,dataCSC);
[dataTraceJ_Light,dataJSearchF_light_shift,indexLight] = TTL_data_Index(par,Timestamps_light,TTLsLight,TimestampsEventLight,dataCSC_light);

%% Plot trace
figure
hold on
plot(data.NRD(1:10000))
plot(data.dataF(1:10000))

%[dataTraceD,~] = traceDSort(par,rez,dataCSC);

%plotTraceChannel(par,dataJSearchF_shift,dataTraceD)

%plotMeanTrace(par,dataJSearchF_shift,dataTraceD)

%plotOneTrace(par,dataJSearchF_light_shift,7,'single'), %single/all

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


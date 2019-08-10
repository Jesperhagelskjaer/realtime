function [] = PCA_Mahanobilis(par,dataTraceJ,dataTraceD,str)

spikes = 500;
cluster = [1 2 3 4 5 6 7 8]; %clu 8 top

[data, c] = data_PCA(dataTraceJ,dataTraceD,spikes,cluster);

[data_N] = data_N_PCA(par,data, c,str);   %P_t: normalize for to power in each trace

data_N_PCA_plotting(data_N,c)

%PCA_Mahanobilis_allCh(dataTraceJ,dataTraceD,spikes,cluster)

%PCA_Mahanobilis_singleCh(dataTraceJ,dataTraceD,spikes,cluster)

%PCA_Mahanobilis_singleCh_N(dataTraceJ,dataTraceD,spikes,cluster) %normalized each own value cluster pr. channels
%PCA_Mahanobilis_singleCh_N2(dataTraceJ,dataTraceD,spikes,cluster) %normalized each cluster with the same value pr. channels


PCA_Mahanobilis_allCh(dataTraceJ,dataTraceD,spikes,cluster)


if 0
    %trying to make the PCA better
close all
x = 1:length(par.xAxis)*4; 
v = data_N(:,1:100);
% Define the query points to be a finer sampling over the range of x.
% 
 xq = 1:1/4:length(par.xAxis)*4;
% Interpolate the function at the query points and plot the result.
figure
vq1 = interp1(x,v,xq);
%plot(x,v,'o',xq,vq1,':.');
plot(xq,vq1,':.');

% xlim([0 2*pi]);
% title('(Default) Linear Interpolation');

movAverage = movmean(vq1,[5 5]);

figure
plot(xq,movAverage) 
v = movAverage(1,:);
B = bsxfun(@minus, movAverage', v');

figure
plot(xq,B)

end
%PCA_Mahanobilis__allCh_N1(par,dataTraceJ,dataTraceD,spikes,cluster) %no    



end


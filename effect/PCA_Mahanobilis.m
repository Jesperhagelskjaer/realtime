function [] = PCA_Mahanobilis(par,dataTraceJ,dataTraceD)

spikes = 5000;
cluster = [1:8]; %clu 8 top

%PCA_Mahanobilis_singleCh(dataTraceJ,dataTraceD,spikes,cluster)

%PCA_Mahanobilis_singleCh_N(dataTraceJ,dataTraceD,spikes,cluster) %normalized each own value cluster pr. channels
%PCA_Mahanobilis_singleCh_N2(dataTraceJ,dataTraceD,spikes,cluster) %normalized each cluster with the same value pr. channels


PCA_Mahanobilis_allCh(dataTraceJ,dataTraceD,spikes,cluster)
%PCA_Mahanobilis__allCh_N1(par,dataTraceJ,dataTraceD,spikes,cluster) %no    



end


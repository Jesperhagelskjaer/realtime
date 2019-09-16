function [data, c] = data_PCA(dataTraceJ,dataTraceD,spikes,cluster)


m = size(dataTraceJ,1)*size(dataTraceJ,2);

data =  reshape(dataTraceJ,[m size(dataTraceJ,3)]);%-meanCh;
data = data(:,1:min(spikes, size(data,2)));
c = ones(1,size(data,2));
try
meanCh = mean(data,2);   %calculate the mean of one channel


for ii = 1:length(cluster)
   
    appenData = reshape(dataTraceD{cluster(ii)},[m size(dataTraceD{cluster(ii)},3)]);%-meanCh_S;
    appenData = appenData(:,1:min(spikes, size(appenData,2)));
    
    meanCh_S = mean(appenData,2);         %calculate the mean of one channel
    meanCh = [meanCh meanCh_S];
    
    c = [c ones(1,size(appenData,2))*(ii+1)];
    
    data = [data appenData];
end
catch
end


end


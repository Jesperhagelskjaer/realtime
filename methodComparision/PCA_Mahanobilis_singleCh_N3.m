function [] = PCA_Mahanobilis__allCh_N1(dataTraceJ,dataTraceD,spikes,cluster) %no 

m = size(dataTraceJ,1)*size(dataTraceJ,2);

data =  reshape(dataTraceJ,[m size(dataTraceJ,3)]);%-meanCh;
data = data(:,1:min(spikes, size(data,2)));

meanCh = mean(data,2);   %calculate the mean of one channel
c = ones(1,size(data,2));
for ii = 1:length(cluster)
    
    
    appenData = reshape(dataTraceD{cluster(ii)},[m size(dataTraceD{cluster(ii)},3)]);%-meanCh_S;
    appenData = appenData(:,1:min(spikes, size(appenData,2)));
    
    meanCh_S = mean(appenData,2);         %calculate the mean of one channel
    meanCh = [meanCh meanCh_S];
    
    c = [c ones(1,size(appenData,2))*(ii+1)];
    
    data = [data appenData];
end



data = data(1:length(par.xAxis),:)-data(1,:);

%data = data/max(max(data));


[coeff,score,latent,tsquared,explained] = pca(data');

figure
subplot(3,2,1)
scatter(score(:,1),score(:,2),[],c,'.')
axis equal
xlabel('1st Principal Component')
ylabel('2nd Principal Component')
subplot(3,2,2)
scatter3(score(:,1),score(:,2),score(:,3),[],c,'.')
axis equal
xlabel('1st Principal Component')
ylabel('2nd Principal Component')
zlabel('3rd Principal Component')
subplot(3,2,[3 4])
plot(data)
subplot(3,2,[5 6])
plot(meanCh);

figure
densityScatter([score(:,1:2)']);


score_cl(:,1) = score(1:min(spikes, size(dataTraceJ,3)),1);
score_cl(:,2) = score(1:min(spikes, size(dataTraceJ,3)),2);

start = min(spikes, size(dataTraceJ,3));

score_c2(:,1) = score(start+1:end,1);
score_c2(:,2) = score(start+1:end,2);
d2_mahal = mahal(mean(score_cl),(score_c2)) %Compute the squared Euclidean distance of each observation in Y from the mean of X .

%d2_Euclidean = sum((score_cl-mean(score_c2)).^2,1)







end


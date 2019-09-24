function [] = PCA_Mahanobilis_allCh(dataTraceJ,dataTraceD,spikes,cluster)

data = permute(dataTraceJ{1},[3 2 1]);
data = reshape(data,size(data,1),[],1);

meanCh = mean(data,1);   %calculate the mean of one channel
c = ones(1,size(data,1));

for ii = 1:length(cluster)
    
    dataP = permute(dataTraceD{cluster(ii)},[3 2 1]);
    appenData = reshape(dataP,size(dataP,1),[],1);
    
    %appenData = appenData(:,1:min(spikes, size(appenData,2)));
    
    meanCh_S = mean(appenData,1);         %calculate the mean of one channel
    meanCh = [meanCh meanCh_S];
    
    c = [c ones(1,size(appenData,1))*(ii+1)];
    
    data = [data; appenData];
end

data = data/max(max(data));


[coeff,score,latent,tsquared,explained] = pca(data);


figure
scatter3(score(:,1),score(:,2),score(:,3),150,c,'.')
axis equal
xlabel('1 - PC')
ylabel('2 - PC')
zlabel('3 - PC')
handleFigurePlot

for m = 1:length(cluster)+1
    for n = 1:length(cluster)+1
        score_cl = [];
        score_c2 = [];
        
        index1 =logical( c == m);
        index2 =logical( c == n);
        
        score_cl(:,1) = score(index1,1);
        score_cl(:,2) = score(index1,2);
        
        score_c2(:,1) = score(index2,1);
        score_c2(:,2) = score(index2,2);
        
        d2_mahal(m,n) = mahal(mean(score_cl),(score_c2)); %Compute the squared Euclidean distance of each observation in Y from the mean of X .
        
    end
end
%d2_Euclidean = sum((score_cl-mean(score_c2)).^2,1)
d2_mahal
end


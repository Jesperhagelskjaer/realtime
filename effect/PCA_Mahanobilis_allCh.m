function [] = PCA_Mahanobilis_allCh(dataTraceJ,dataTraceD,spikes,cluster)


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

[coeff,score,latent,tsquared,explained] = pca(data');

figure
subplot(3,2,1)
scatter(score(:,1),score(:,2),[],c,'.')
axis equal
xlabel('1st Principal Component')
ylabel('2nd Principal Component')
subplot(3,2,2)
scatter3(score(:,1),score(:,2),score(:,3),0.02,c,'.')
axis equal
xlabel('1st Principal Component')
ylabel('2nd Principal Component')
zlabel('3rd Principal Component')
subplot(3,2,[3 4])
plot(data)
subplot(3,2,[5 6])
plot(meanCh);

%figure
%densityScatter([score(:,1:2)']);
score1 = score(logical(c == 1),1:3);
score2 = score(logical(c == 2),1:3);
score3 = score(logical(c == 3),1:3);
score4 = score(logical(c == 4),1:3);
score5 = score(logical(c == 5),1:3);
score6 = score(logical(c == 6),1:3);
score7 = score(logical(c == 7),1:3);
score8 = score(logical(c == 8),1:3);
score9 = score(logical(c == 9),1:3);

figure
hold on
scatter3(score1(:,1),score1(:,2),score1(:,3),0.002,'.','DisplayName','J-1')
scatter3(score2(:,1),score2(:,2),score2(:,3),0.002,'.','DisplayName','D-1')
scatter3(score3(:,1),score3(:,2),score3(:,3),0.002,'.','DisplayName','D-2')
scatter3(score4(:,1),score4(:,2),score4(:,3),0.002,'.','DisplayName','D-3')
scatter3(score5(:,1),score5(:,2),score5(:,3),0.002,'.','DisplayName','D-3')
scatter3(score6(:,1),score6(:,2),score6(:,3),0.002,'.','DisplayName','D-4')
scatter3(score7(:,1),score7(:,2),score7(:,3),0.002,'.','DisplayName','D-5')
scatter3(score8(:,1),score8(:,2),score8(:,3),0.002,'.','DisplayName','D-6')
scatter3(score9(:,1),score9(:,2),score9(:,3),0.002,'.','DisplayName','D-7')
legend
axis equal
xlabel('1st Principal Component')
ylabel('2nd Principal Component')
zlabel('3rd Principal Component')
handleFigurePlot

figure
hold on
scatter3(score1(:,1),score1(:,2),score1(:,3),0.002,'.','DisplayName','J-1')
%scatter3(score2(:,1),score2(:,2),score2(:,3),0.002,'.','DisplayName','D-1')
scatter3(score3(:,1),score3(:,2),score3(:,3),0.002,'.','DisplayName','D-2')
scatter3(score4(:,1),score4(:,2),score4(:,3),0.002,'.','DisplayName','D-3')
%scatter3(score5(:,1),score5(:,2),score5(:,3),0.002,'.','DisplayName','D-4')
%scatter3(score6(:,1),score6(:,2),score6(:,3),0.002,'.','DisplayName','D-5')
%scatter3(score7(:,1),score7(:,2),score7(:,3),0.002,'.','DisplayName','D-6')
%scatter3(score8(:,1),score8(:,2),score8(:,3),0.002,'.','DisplayName','D-7')
%scatter3(score9(:,1),score9(:,2),score9(:,3),2,'o','DisplayName','D-8')
legend
xlabel('1st Principal Component')
ylabel('2nd Principal Component')
zlabel('3rd Principal Component')


figure
scatter3(score(:,1),score(:,2),score(:,3),0.002,c,'.')
axis equal
xlabel('1st Principal Component')
ylabel('2nd Principal Component')
zlabel('3rd Principal Component')
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


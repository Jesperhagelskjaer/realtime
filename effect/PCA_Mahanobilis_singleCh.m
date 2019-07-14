function [] = PCA_Mahanobilis_singleCh(dataTraceJ,dataTraceD,spikes,cluster)


for i = 1:size(dataTraceJ,2)
    data = [];                                                  %not strickly nessseary
    meanCh = [];                                                %not strickly nessseary
    
    meanCh = mean(squeeze(dataTraceJ(:,i,:)),2);                %calculate the mean of one channel
    data =  squeeze(dataTraceJ(:,i,1:min(spikes, size(dataTraceJ,3))));%-meanCh; %min is used if to many spikes is as for
    c = ones(1,size(data,2));
    for ii = 1:length(cluster)

        meanCh_S = mean(squeeze(dataTraceD{cluster(ii)}(:,i,:)),2);         %calculate the mean of one channel
        meanCh = [meanCh meanCh_S];                                %create the holder for the mean template for plotting
        
        appenData = squeeze(dataTraceD{cluster(ii)}(:,i,1:min(spikes, size(dataTraceD{cluster(ii)},3))));%-meanCh_S;
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
    scatter3(score(:,1),score(:,2),score(:,3),[],c,'.')
    axis equal
    xlabel('1st Principal Component')
    ylabel('2nd Principal Component')
    zlabel('3rd Principal Component')
    subplot(3,2,[3 4])
    plot(data')
    subplot(3,2,[5 6])
    plot(meanCh);  
  
    if ii < 2

     score_cl(:,1) = score(1:min(spikes, size(dataTraceJ,3),1)); 
     score_cl(:,2) = score(1:min(spikes, size(dataTraceJ,3),2));
     
     score_c2(:,1) = score(min(spikes, size(dataTraceJ,3))+1:min(spikes, size(dataTraceD{cluster(ii)},3))); 
     score_c2(:,2) = score(min(spikes, size(dataTraceJ,3))+1:min(spikes, size(dataTraceD{cluster(ii)},3)));
      
     d2_mahal(i) = mahal(mean(score_cl),(score_c2)); %Compute the squared Euclidean distance of each observation in Y from the mean of X .
   
     %d2_Euclidean = sum((score_cl-mean(score_c2)).^2,1) not done
    end
    
    end

if ii < 2
d2_mahal
end
end


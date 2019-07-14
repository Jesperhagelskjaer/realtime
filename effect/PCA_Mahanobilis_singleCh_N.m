function [] = PCA_Mahanobilis_singleCh_N(dataTraceJ,dataTraceD,spikes,cluster)



for i = 1:size(dataTraceJ,2)
    data = [];                                                  %not strickly nessseary
    meanCh = [];                                                %not strickly nessseary
    
    meanCh = mean(squeeze(dataTraceJ(:,i,:)),2);                %calculate the mean of one channel
    data =  squeeze(dataTraceJ(:,i,1:min(spikes, size(dataTraceJ,3))));%-meanCh; %min is used if to many spikes is as for
    std_V = std(data,[],2);
    data = data./std_V;
    c = ones(1,size(data,2));
    for ii = 1:length(cluster)

        meanCh_S = mean(squeeze(dataTraceD{cluster(ii)}(:,i,:)),2);         %calculate the mean of one channel
        meanCh = [meanCh meanCh_S];                                %create the holder for the mean template for plotting
        
        appenData = squeeze(dataTraceD{cluster(ii)}(:,i,1:min(spikes, size(dataTraceD{cluster(ii)},3))));%-meanCh_S;
        std_V = std(appenData,[],2);
        appenData = appenData./std_V;
        
        c = [c ones(1,size(appenData,2))*(ii+1)];

        data = [data appenData];
    end
       
    [coeff,score,latent,tsquared,explained] = pca(data');
    
    figure
    subplot(2,2,1)
    scatter(score(:,1),score(:,2),[],c,'.')
    axis equal
    xlabel('1st Principal Component')
    ylabel('2nd Principal Component')
    subplot(2,2,2)
    scatter3(score(:,1),score(:,2),score(:,3),[],c,'.')
    axis equal
    xlabel('1st Principal Component')
    ylabel('2nd Principal Component')
    zlabel('3rd Principal Component')
    subplot(2,2,[3 4])
    plot(meanCh);  
    


end


end





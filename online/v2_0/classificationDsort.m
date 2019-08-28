function [par] = classificationDsort(par,dataF,rez)

jitter = par.jitter;
clusterDSort = rez.st(rez.st(:,1) < par.lengthGroundt,8);

shift = par.order/2;

time = rez.st(find(rez.st(:,1) < par.lengthGroundt),1) + shift;


for ii = 1:length(par.template)
                                                                              
    timeDSortSearch = rez.st(find(rez.st(:,8) == par.template(ii)),1) ;
    timeDSortSearch( timeDSortSearch > par.lengthGroundt) = [];
    
    JSortTime = par.passed + shift;
    
    spikeHolder = nan(length([-10:40]),par.spatial,length(JSortTime));
    spikeHolderHard = spikeHolder;
    spikeHolderMiss = spikeHolder;
    spikeHolderHardMiss = spikeHolder;
    spikeHolderD = nan(length([-10:40]),par.spatial,length(timeDSortSearch));
    spikeHolderHardD = spikeHolderD;
    spikeHolderMissD = spikeHolderD;
    spikeHolderHardMissD = spikeHolderD;

    clusterholder = [];clusterholderMiss = [];clusterholderD = [];clusterholderMissD = []; 
 
    m = 0;    k = 0;
    for i = 1:length(JSortTime)
        holder = ismembc(time,JSortTime(i)+[-jitter:jitter]);
        %holder2 = find(time,JSortTime(i)+[-jitter:jitter]);
        if (any(holder))
            m = m +1;
            clusterholder = [clusterholder clusterDSort(holder)'];
            spikeHolder(:,:,m) = dataFilt([-10:40]+JSortTime(i),:);
            spikeHolderHard(:,:,m) = dataFF([-10:40]+JSortTime(i),:);
        else %error here
            k = k + 1;
            clusterholderMiss = [clusterholderMiss JSortTime(i)'];
            spikeHolderMiss(:,:,k) = dataFilt([-10:40]+JSortTime(i),:);
            spikeHolderHardMiss(:,:,k) = dataFF([-10:40]+JSortTime(i),:);
        end
    end
    
    mm = 0; kk = 0;
    for i = 1:length(timeDSortSearch)-1
        holder = ismembc(JSortTime,timeDSortSearch(i)+[-jitter:jitter]);
        if (any(holder))
            mm = mm +1;
            clusterholderD = [clusterholderD JSortTime(holder)']; %Time looking only for one neuron
            spikeHolderD(:,:,mm) = dataFilt([-10:40]+timeDSortSearch(i),:);
            spikeHolderHardD(:,:,mm) = dataFF([-10:40]+timeDSortSearch(i),:);
            
        else
            kk = kk + 1;
            clusterholderMissD = [clusterholderMissD timeDSortSearch(i)'];
            spikeHolderMissD(:,:,kk) = dataFilt([-10:40]+timeDSortSearch(i),:);
            spikeHolderHardMissD(:,:,kk) = dataFF([-10:40]+timeDSortSearch(i),:);
        end
    end
    
    figure('NumberTitle', 'off', 'Name', ['cluster ', num2str(par.template(ii)), '  ', stringToPrint]);

    subplot(2,2,1)
    surf(nanmean(spikeHolder,3))
    title(['JSearch filt f hits in Jsearch, total spikes  = ',num2str(length(JSortTime))])
    subplot(2,2,2)
    surf(par.reCalculateTemplate{ii})
    title(['template used from Dsort,  Total spikes = ',num2str(length(timeDSortSearch))])
    subplot(2,2,3)
    surf(nanmean(spikeHolderHard,3))
    title('F-B Butterwards')
    subplot(2,2,4)
    edges = [1:150];
    histogram(clusterholder',edges)
    
    par.extraCluster{ii} = clusterholder;

    
%     figure
%     subplot(2,1,1)
%     surf(nanmean(spikeHolderMiss,3))
%     title('Not found in Dsort')
%     subplot(2,1,2)
%     surf(nanmean(spikeHolderHardMiss,3))
%     title('F-B Not found in Dsort')
%     
%     figure
%     subplot(2,1,1)
%     surf(nanmean(spikeHolderMissD,3))
%     title('Not found in JSearch')
%      subplot(2,1,2)
%     surf(nanmean(spikeHolderHardMissD,3))
%     title('F-B Not found in JSearch')
    
end


end





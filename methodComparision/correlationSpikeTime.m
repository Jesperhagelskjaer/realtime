function [] = correlationSpikeTime(par,datum)

t_MC_c = datum.tSpikes_MClust;
t_DS_c = datum.tSpikes_DSort_cor;
jitter = par.jitter;

largest = size(t_DS_c,2);

%% In agreement

for i = 1:largest
    c = 1;
    t_DS = datum.tSpikes_DSort_cor{i};
    clusterSeenT = [];
    holderA_seen = [];holderA_NotSeen = [];
    for ii = 1:length(t_DS)
        clusterSeen = [];
        bool = 1;
        for MC = 1:size(datum.tSpikes_MClust,2)
            
            t_MC = datum.tSpikes_MClust{MC};
            index = floor(find(t_DS(ii)- jitter < t_MC  & t_DS(ii) + jitter > t_MC));
            if ~isempty(index)
                clusterSeen = [clusterSeen MC];
                holderA_seen= cat(3,holderA_seen,datum.spikes_DSort_cor{i}(:,:,ii));
                bool = 0;
            end
        end
        if bool
            c = c + 1;
            clusterholderNonSeen{i} = c; %not seen in any of the MCust template
            holderA_NotSeen= cat(3,holderA_NotSeen,datum.spikes_DSort_cor{i}(:,:,ii));
        end
        
        clusterSeenT = [clusterSeenT clusterSeen];
        
    end
    clusterholderT{i} = clusterSeenT;
    clusterWave_seen{i}  = holderA_seen;
    clusterWave_Notseen{i}  = holderA_NotSeen;
end

for i = 1:size(t_MC_c,2)
    c = 1;
    t_MS = datum.tSpikes_MClust{i};
    clusterSeenT_MC = [];
    for ii = 1:length(t_MS)
        clusterSeen_MC = [];
        bool = 1;
        for MC = 1:size(datum.tSpikes_DSort_cor,2)
            
            t_MC = datum.tSpikes_DSort_cor{MC};
            index = floor(find(t_MS(ii)- jitter < t_MC  & t_MS(ii) + jitter > t_MC));
            if ~isempty(index)
                clusterSeen_MC = [clusterSeen_MC MC];
                bool = 0;
            end
        end
        if bool
            c = c + 1;
            clusterholderNonSeen_MC{i} = c; %not seen in any of the MCust template
        end
        
        clusterSeenT_MC = [clusterSeenT_MC clusterSeen_MC];
        
    end
    clusterholderT_MC{i} = clusterSeenT_MC;
end

sample = nan(size(t_DS_c,2)+1,size(t_MC_c,2)+1);

for i = 1:size(t_DS_c,2)+1
    dSort{i} = strcat('Dsort_T',num2str(i));
    if i > size(t_DS_c,2)
        dSort{i} = 'only';
    end
end

for i = 1:size(t_MC_c,2)+1
    Mcluster{i} = strcat('MCLust_T ',num2str(i));
    if i > size(t_MC_c,2)
        Mcluster{i} = 'only';
    end
end

for i = 1:largest
    for ii = min(clusterholderT{i}):max(clusterholderT{i})
        sample(i,ii) = length(find(clusterholderT{i} == ii));
        if i == ii
            WS_All{i} = clusterWave_seen{i};
        end
    end
    
end

for i = 1:size(t_DS_c,2)
    sample(i,end) = clusterholderNonSeen{i};
    WS_All{i+largest} = clusterWave_Notseen{i};
end

m = size(WS_All,2);
for i = 1:size(t_MC_c,2)
    sample(end,i) = clusterholderNonSeen_MC{i};
    %WS_All{i+m} = clusterWave_seen{i}
end
datum.WS_All = WS_All;
datum.inAgreement = clusterWave_seen;
datum.CS_NSI_MC = clusterWave_Notseen;

sTable = array2table(sample,'RowNames',dSort,'VariableNames',Mcluster);
sTable
PCA_Mahanobilis_allCh(par,datum,'C_PCA',[1 2 3 4],'alignment','min') %


end

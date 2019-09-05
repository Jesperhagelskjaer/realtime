function [datum] = correlationSpikeTime(par,rez,datum)


if ~exist('datum.error','var')
    datum.errorTxt = 'NO_T_DS';
    
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
            for MC = 1:size(datum.tSpikes_MClust_cor,2)
                
                t_MC = datum.tSpikes_MClust_cor{MC};
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
        CS_A{i}  = holderA_seen;
        CS_NSI_MC{i}  = holderA_NotSeen;
    end
    
    for i = 1:size(t_MC_c,2)
        c = 1;
        t_MS = datum.tSpikes_MClust_cor{i};
        clusterSeenT_MC = [];CW_NSI_DS_h = [];
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
                clusterholderNonSeen_MC{i} = c; %not seen in any of the DSort template
                CW_NSI_DS_h= cat(3,CW_NSI_DS_h,datum.spikes_MClust_cor{i}(:,:,ii));
            end
            
            clusterSeenT_MC = [clusterSeenT_MC clusterSeen_MC];
            
        end
        clusterholderT_MC{i} = clusterSeenT_MC;
        CW_NSI_DS{i}         = CW_NSI_DS_h;
    end
    
    mid.t_DS_c         = t_DS_c;
    mid.t_MC_c         = t_MC_c;
    mid.clusterholderT = clusterholderT;
    mid.CS_A           = CS_A;
    mid.clusterholderNonSeen = clusterholderNonSeen;
    mid.CS_NSI_MC           =   CS_NSI_MC;
    mid.clusterholderNonSeen_MC = clusterholderNonSeen_MC;
    mid.CW_NSI_DS = CW_NSI_DS;
    
    
    
    [WS_All,label_WS_All] = table_confusion(par,datum,mid);
    
    datum.CS_All        = WS_All;
    datum.CS_A          = CS_A;
    datum.CS_NSI_MC     = CS_NSI_MC;
    datum.label_WS_All  = label_WS_All; %1 agreemen, 2 NSI_MS, 3 NSI_DS
    %extraCheckTime(par,rez,datum,4);
    
end
end

function [datum] = correlationSpikeTime_D_J(par,rez,datum)


if ~exist('datum.error','var')
    datum.errorTxt = 'NO_T_DS';
    
    t_MC_c = datum.CW_t_JS_cor;
    t_DS_c = datum.tSpikes_DSort_cor;

    jitter = par.jitter;
    
    %% In agreement
    
    for i = 1:size(t_DS_c,2)
        c = 0;
        t_DS = datum.tSpikes_DSort_cor{i};
        CN_A_DS = [];CW_A = [];CW_NSI_MS = [];t_A = []; t_NSI_MC = [];
        for ii = 1:length(t_DS)
            bool = 1;
            for MC = 1:size(datum.CW_t_JS_cor,2) %cluster in MClust
                
                t_MC = datum.CW_t_JS_cor{MC}-16;
                index = floor(find(t_DS(ii)- jitter < t_MC  & t_DS(ii) + jitter > t_MC));
                if ~isempty(index)
                    CN_A_DS = [CN_A_DS MC]; %the cluster number in agreement
                    CW_A = cat(3,CW_A,datum.spikes_DSort_cor{i}(:,:,ii)); %the waveform in agreement
                    t_A  = [t_A t_DS(ii)]; %the timeindex in agreement
                    bool = 0;
                end
            end
            if bool %if there is no spikes in MCLust there is in agreement is must be NSI_MC varaiable
                c            = c + 1; %count the total number of NSI_MC for each cluster          
                t_NSI_MC     = [t_NSI_MC t_DS(ii)]; %the time index for the NSI_MC
                CW_NSI_MS    = cat(3,CW_NSI_MS,datum.spikes_DSort_cor{i}(:,:,ii)); %the waveform NSI_MClust
            
            end

        end
        CN_NSI_MC(i)      = c; %not seen in any of the MClust template
        CN_A_DS_h{i}      = CN_A_DS; %clusterholderT
        CW_A_h{i}         = CW_A;
        t_A_h{i}          = t_A;
        t_NSI_MC_h{i}     = t_NSI_MC;
    end
    
    for i = 1:size(t_MC_c,2)
        c = 0;
        t_MS = datum.CW_t_JS_cor{i};
        CW_NSI_DS = [];t_NSI_DS = [];CN_A_MC = [];
        for ii = 1:length(t_MS)
            %clusterSeen_MC = [];
            bool = 1;
            for MC = 1:size(datum.tSpikes_DSort_cor,2)
                
                t_MC = datum.tSpikes_DSort_cor{MC};
                index = floor(find(t_MS(ii)- jitter < t_MC  & t_MS(ii) + jitter > t_MC));
                if ~isempty(index)
                    CN_A_MC = [CN_A_MC MC];
                    bool = 0;
                end
            end
            if bool
                c = c + 1;          
                t_NSI_DS     = [t_NSI_DS t_MS(ii)];
                CW_NSI_DS  = cat(3,CW_NSI_DS,datum.CW_JS_cor{i}(:,:,ii));
            end
        
        end
        CN_NSI_DS{i}         = c; 
        CN_A_MC_h{i}         = CN_A_MC;
        CW_NSI_DS_h{i}       = CW_NSI_DS;
        t_NSI_DS_h{i}        = t_NSI_DS;       
    end
    
    mid.CN_A_DS           = CN_A_DS_h; 
    mid.CN_A_MC           = CN_A_MC_h; 
    mid.CN_NSI_DS         = CN_NSI_DS;
%    mid.CN_NSI_MC      = CN_NSI_MC_h;
    
    mid.CS_A           = CW_A_h;
    mid.CW_NSI_DS      = CW_NSI_DS_h;
    mid.CN_NSI_MC      = CN_NSI_MC;
    
    mid.t_DS_c         = t_DS_c;
    mid.t_MC_c         = t_MC_c;
    mid.t_NSI_DS       = t_NSI_DS_h;
    mid.t_NSI_MC       = t_NSI_MC_h; 
    mid.t_A            = t_A_h; 
  
    [WS_All,label_WS_All,t_all] = table_confusion(par,datum,mid);
    
    datum.CW_All        = datum.CW_DS;
    datum.CW_All(end+1) = datum.CW_JS;
    
    
    datum.CS_A          = CW_A_h;
    datum.label_WS_All  = label_WS_All; %1 agreemen, 2 NSI_MS, 3 NSI_DS
    datum.t_A           = t_A_h;
    datum.t_all         = t_all;
    %extraCheckTime(par,rez,datum,4);
    
end
end

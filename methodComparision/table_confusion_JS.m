function [WS_All,label_WS_All,t_all] = table_confusion(par,datum,mid)

CN_A_DS        = mid.CN_A_DS;
CN_NSI_DS      = mid.CN_NSI_DS;


%CS_A           = mid.CW_A;
CW_NSI_DS      = mid.CW_NSI_DS;
CN_NSI_MC      = mid.CN_NSI_MC;

t_DS_c         = mid.t_DS_c;
t_MC_c         = mid.t_MC_c;
t_NSI_DS       = mid.t_NSI_DS;
t_NSI_MC       = mid.t_NSI_MC;
%t_A            = mid.t_A_h;


% %CN_NSI_MC = mid.CN_NSI_MC;
% CS_NSI_MC = mid.CS_NSI_MC;
% clusterholderNonSeen_MC = mid.CN_NSI_MC;
% CW_NSI_DS = mid.CW_NSI_DS;
% largest = size(t_DS_c,2);
%
 sample = nan(size(t_DS_c,2)+1,size(t_MC_c,2)+1);

for i = 1:size(t_DS_c,2)+1 %creates the name for table
    dSort{i} = strcat('Dsort_T',num2str(i));
    if i > size(t_DS_c,2)
        dSort{i} = 'only';
    end
end

for i = 1:size(t_MC_c,2)+1 %creates the name for table
    Mcluster{i} = strcat('MClust_T ',num2str(i));
    if i > size(t_MC_c,2)
        Mcluster{i} = 'only';
    end
end
label_WS_All = [];
t_all        = [];

for i = 1:largest %in agreement
    for ii = min(clusterholderT{i}):max(clusterholderT{i})
        sample(i,ii) = length(find(clusterholderT{i} == ii));
        if i == ii
            WS_All{i} = CS_A{i};
            label_WS_All(end+1) = 1;
        end
    end
    t_all =  mid.t_A;
    index = size(t_all,2);
end

%1 agreement, 2 NSI_MS, 3 NSI_DS

for i = 1:size(t_DS_c,2) %Not seen in MClust
    sample(i,end)       = clusterholderNonSeen{i};
    WS_All{i+index}     = CS_NSI_MC{i};
    label_WS_All(end+1) = 2;
    t_all{i+index}      = mid.t_NSI_MC{i};
end

m = size(WS_All,2);
index = size(t_all,2);
for i = 1:size(t_MC_c,2) %Not seen in DSORT
    sample(end,i)       = clusterholderNonSeen_MC{i};
    WS_All{i+m}         = CW_NSI_DS{i};
    label_WS_All(end+1) = 3;
    t_all{i+index}        = mid.t_NSI_DS{i};
end

sTable = array2table(sample,'RowNames',dSort,'VariableNames',Mcluster)

filename = strcat(par.path,'\jesper\bundle',num2str(ceil(max(par.template_LFP{2})/4)-1),'_confusionMatrix','.xlsx');
%writetable(sTable,filename,'WriteRowNames',true)

end

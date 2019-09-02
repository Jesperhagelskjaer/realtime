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
    for ii = 1:length(t_DS)
        clusterSeen = [];
        bool = 1;
        for MC = 1:size(datum.tSpikes_MClust,2)
            
            t_MC = datum.tSpikes_MClust{MC};
            index = floor(find(t_DS(ii)- jitter < t_MC  & t_DS(ii) + jitter > t_MC));
            if ~isempty(index)
                clusterSeen = [clusterSeen MC];
                bool = 0;   
            end
        end
        if bool   
            c = c + 1;
            clusterholderNonSeen{i} = c; %not seen in any of the MCust template
        end
        
        clusterSeenT = [clusterSeenT clusterSeen];
    
    end
    clusterholderT{i} = clusterSeenT;
end






% sample = rand(3,3);
% for i = 1:size(t_DS_c,2)+1
%     dSort{i} = strcat('Dsort_T',num2str(i));
%     if i > size(t_DS_c,2)
%         dSort{i} = 'only';
%     end
% end
% for i = 1:size(t_MC_c,2)+1
%     Mcluster{i} = strcat('MCLust_T ',num2str(i));
%     if i > size(t_MC_c,2)
%         Mcluster{i} = 'only';
%     end
% end
%
% for i = 1:largest
%     sample(i,i) = size(inAgreement1{i},3);
% end
%
% for i = 1:largest
%     for ii = min(AnotherCLuster{i}):max(AnotherCLuster{i})
%         number = length(find(AnotherCLuster{i} == ii));
%         if number > 0
%             sample(i,ii) = number;
%         end
%     end
% end
%
% for i = 1:size(notfoundInDSort,2)
%     sample(i,end) = size(notFoundInanotherCluster{i},2);
% end
%
% for i = 1:size(notfoundInMClust,2)
%     sample(end,i) = size(notFoundInanotherCluster2{i},2);
% end
%
% sample(end,end) = nan;
%
% sTable = array2table(sample,'RowNames',dSort,'VariableNames',Mcluster)
% b = 2;
% % filename = strcat(par.path,'\bundle',num2str(ceil(max(par.template_LFP{2})/4)-1),'.xlsx');






end








% if size(t_MC_c,2) > size(t_DS_c,2)
%     mC_largest = size(t_MC_c,2);
%     largest = mC_largest;
% elseif size(t_MC_c,2) < size(t_DS_c,2)
%     mD_largest = size(t_DS_c,2);
%     largest = mD_largest;
% else
%     equalSize = size(t_DS_c,2);
%     largest = size(t_DS_c,2);
% end





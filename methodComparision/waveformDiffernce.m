function [] = waveformDiffernce(par,datum)

t_MC_c = datum.tSpikes_MClust;
t_DS_c = datum.tSpikes_DSort_cor;
jitter = par.jitter;

largest = size(t_DS_c,2);

%% In agreement
AnotherCLuster = [];notFoundInanotherCluster = [];
for i = 1:largest
    extra_1 = 1;
    extra_2 = 1;
    c_1 = 1;
    c_2 = 1;
    t_MC = datum.tSpikes_MClust{i};
    t_DS = datum.tSpikes_DSort_cor{i};
    for ii = 1:length(t_DS)
        t_MC = datum.tSpikes_MClust{i};
        index = floor(find(t_DS(ii)- jitter < t_MC  & t_DS(ii) + jitter > t_MC)); %the floor is more than one value is present
        if index
            inAgreement1{i}(:,:,c_1) = datum.spikes_DSort_cor{i}(:,:,ii);
            c_1 = c_1 + 1;
        else %not found in the the same cluster
            notfoundInMClust{i}(:,:,c_2) = datum.spikes_DSort_cor{i}(:,:,ii);
            c_2 = c_2 + 1;
            bool = 1;
            for tt = 1:size(datum.tSpikes_MClust,2) %check if it is in another cluster
                index = floor(find(t_DS(ii)- jitter < datum.tSpikes_MClust{tt}  & t_DS(ii) + jitter > datum.tSpikes_MClust{tt}));
                if index
                    AnotherCLuster{i}(extra_1) = tt;
                    extra_1 = extra_1 +1;
                    bool = 0;
                end
            end
            if bool
                notFoundInanotherCluster{i}(extra_2) = nan;
                extra_2 = extra_2 +1;
            end
        end
    end
end

sample = rand(3,3);
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
    sample(i,i) = size(inAgreement1{i},3);
end

for i = 1:largest
    for ii = min(AnotherCLuster{i}):max(AnotherCLuster{i})
        number = length(find(AnotherCLuster{i} == ii));
        if number > 0
            sample(i,ii) = number;
        end
    end
end

for i = 1:size(notfoundInDSort,2)
    sample(i,end) = size(notFoundInanotherCluster{i},2);
end

for i = 1:size(notfoundInMClust,2)
    sample(end,i) = size(notFoundInanotherCluster2{i},2);
end

sample(end,end) = nan;

sTable = array2table(sample,'RowNames',dSort,'VariableNames',Mcluster)
 b = 2;
% filename = strcat(par.path,'\bundle',num2str(ceil(max(par.template_LFP{2})/4)-1),'.xlsx');   
% writetable(sTable,filename,'WriteRowNames',true)
% datum.inAgreement1 = inAgreement1;
%%PCA_Mahanobilis_allCh(par,datum)
% figure
% surf(mean(inAgreement1{1},3))
% title('inAgreement1')
% figure
% surf(mean(inAgreement1{2},3))
% title('inAgreement1')
% figure
% surf(mean(notfoundInMClust{1},3))
% title('notfoundInMClust')
% figure
% surf(mean(notfoundInMClust{2},3))
% title('notfoundInMClust')
% figure
% surf(mean(notfoundInDSort{1},3))
% title('notfoundInDSort')
% figure
% surf(mean(notfoundInDSort{2},3))
% title('notfoundInDSort')





end
% AnotherCLuster = [];notFoundInanotherCluster = [];
% for i = 1:largest
%     extra_1 = 1;
%     extra_2 = 1;
%     c_1 = 1;
%     c_2 = 1;
%     t_MC = datum.tSpikes_MClust{i};
%     t_DS = datum.tSpikes_DSort_cor{i};
%     for ii = 1:length(t_DS)
%         index = floor(find(t_DS(ii)- jitter < t_MC  & t_DS(ii) + jitter > t_MC)); %the floor is more than one value is present
%         if index
%             inAgreement1{i}(:,:,c_1) = datum.spikes_DSort_cor{i}(:,:,ii);
%             c_1 = c_1 + 1;
%         else %not found in the the same cluster
%             notfoundInMClust{i}(:,:,c_2) = datum.spikes_DSort_cor{i}(:,:,ii);
%             c_2 = c_2 + 1;
%             bool = 1;
%             for tt = 1:size(datum.tSpikes_MClust,2) %check if it is in another cluster
%                 index = floor(find(t_DS(ii)- jitter < datum.tSpikes_MClust{tt}  & t_DS(ii) + jitter > datum.tSpikes_MClust{tt}));
%                 if index
%                     AnotherCLuster{i}(extra_1) = tt;
%                     extra_1 = extra_1 +1;
%                     bool = 0;
%                 end
%             end
%             if bool
%                 notFoundInanotherCluster{i}(extra_2) = nan;
%                 extra_2 = extra_2 +1;
%             end
%         end
%     end
% end
% AnotherCLuster2 = [];notFoundInanotherCluster2 = [];
% for i = 1:largest
%     c_1 = 1;
%     extra_1 = 1;
%     extra_2 = 1;
%     t_MC = datum.tSpikes_MClust{i};
%     t_DS = datum.tSpikes_DSort_cor{i};
%     for ii = 1:length(t_MC)
%         index = floor(find(t_MC(ii) - jitter < t_DS  & t_MC(ii) + jitter > t_DS)); %the floor is more than one value is present
%         if isempty(index)
%             notfoundInDSort{i}(:,:,c_1) = datum.spikes_MClust{i}(:,:,ii);
%             c_1 = c_1 + 1;
%             bool = 1;
%             for tt = 1:size(datum.tSpikes_DSort_cor,2) %check if it is in another cluster
%                 index = floor(find(t_MC(ii)- jitter < datum.tSpikes_DSort_cor{tt}  & t_MC(ii) + jitter > datum.tSpikes_DSort_cor{tt}));
%                 if index
%                     AnotherCLuster2{i}(extra_1) = tt;
%                     extra_1 = extra_1 +1;
%                     bool = 0;
%                 end
%             end
%             if bool
%                 notFoundInanotherCluster2{i}(extra_2) = nan;
%                 extra_2 = extra_2 +1;
%             end
%         end
%     end
% end







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




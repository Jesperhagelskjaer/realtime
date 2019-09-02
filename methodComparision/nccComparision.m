function [datum] = nccComparision(par,datum)


for i = 1:size(datum.template_mean_DSort,2)
    template = datum.template_mean_DSort{i};
    
    for j = 1:size(datum.template_mean_MClust,2)
        signal = [zeros(20,4); datum.template_mean_MClust{j}; zeros(20,4)];
        
        NCC_value = normxcorr2_mex(template,signal);
        NCC_value1 = NCC_value(:,4); %change the 3
        NCC_value2(i,j) = max(NCC_value1); %i = dsort, j MCLust

    end
end
holder = NCC_value2;
shufleVector = nan(1,max([size(holder,1),size(holder,2)]));

for j = 1:min(size(holder)) %look into which have fewer cluster  
    maximum = max(max(holder));
    [m,n]=find(holder==maximum);
    shufleVector(1,m) =  n; 
    holder(m,:) = nan;
    holder(:,n) = nan;
end

for i = 1:length(shufleVector)
    index = find(shufleVector == i);
        if isempty(index)
            shufleVector(find(isnan(shufleVector), 1)) = i;
        end
end
   
datum.shuffleVector = shufleVector;

datum.tSpikes_DSort_cor = datum.tSpikes_DSort(shufleVector);
datum.spikes_DSort_cor   = datum.spikes_DSort(shufleVector);
plotCorredTemplate(par,datum)
correlationSpikeTime(par,datum)
%waveformDiffernce(par,datum)


end

% for j = 1:min(size(NCC_value2)) %look into which have fewer cluster  
%     [~,index] = max(NCC_value2(j,:));   
%     shufleVector(j) = index;
% end
function [datum] = traceMClust(par,datum)

try
    for i = 1:size(datum.tSpikes_MClust,2)
        time = datum.tSpikes_MClust{i};
        for ii = 1:length(time)
            datum.spikes_MClust{i}(:,:,ii) = datum.CSC_F(par.xAxis+time(ii),:); %allocate and check out of bounds
        end
        datum.template_mean_MClust{i} = mean(datum.spikes_MClust{i},3);
    end
catch
    
end

end


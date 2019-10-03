function [datum] = traceDSort(par,rez,datum)

try
    data = datum.NRD_F;
catch
   data = datum.CSC_f; 
end

clustNr = [];
for i = 1:size(rez.Chan,1)
    if any(intersect(rez.Chan{i},par.chs{2}))
        clustNr = [clustNr i];
    end
end
for i = 1:length(clustNr)
    
    index = rez.st(logical(rez.st(:,end) == clustNr(i)),1);
    
    for ii = 1:length(index)
        %if (index(ii) >= size1-length(par.xAxis) || index(ii) <= length(par.xAxis))
        %    fprintf('The range is to big\n')
        %    index(i) = nan;
        %else
        datum.spikes_DSort{i}(:,:,ii) = data(par.xAxis+index(ii),:);
        datum.CW_DS{i}(:,:,ii)= data(par.xAxis+index(ii),:);
    end
    datum.template_mean_DSort{i} = mean(datum.spikes_DSort{i},3);
    datum.tSpikes_DSort{i} = index; %need to be here change code
end
end


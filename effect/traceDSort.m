function [dataTrace,clustNr,indexH] = traceDSort(par,rez,data)


size1 = size(data,1);

clustNr = [];
for i = 1:size(rez.Chan,1)
    if any(intersect(rez.Chan{i},par.template_LFP{2}))
        clustNr = [clustNr i];
    end   
end
for i = 1:length(clustNr)
    
    index = rez.st(logical(rez.st(:,end) == clustNr(i)),1);
    %index(index > 54149120) = []; %check this part it due to the concatunation
    
    indexH{i} = index;
    for ii = 1:length(index)
        if (index(ii) >= size1-length(par.xAxis) || index(ii) <= length(par.xAxis))
        
            fprintf('The range is to big\n')
        else
            dataTrace{i}(:,:,ii) = data(par.xAxis+index(ii),:);
        end
    end
end
end

function [dataTrace] = traceDSort(par,rez,data)
clustNr = [];
for i = 1:size(rez.Chan,1)
    if any(intersect(rez.Chan{i},par.template_LFP{2}))
        clustNr = [clustNr i];
    end
    
end
for i = 1:length(clustNr)
    index = rez.st(logical(rez.st(:,end) == clustNr(i)),1);
    
    index(index > 54149120) = []; %check this part it due to the concatunation
    for ii = 1:length(index)
        dataTrace{i}(:,:,ii) = data(par.xAxis+index(ii),:);
        
    end
end

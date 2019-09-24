function [dataTrace,clustNr,indexH] = traceDSort(par,rez,datum)

data = datum.CSC{1}; %check could give errror with multiple paths
xAxis = par.xAxis;  
size1 = size(data,1);

clustNr = [];

for i = 1:size(rez.Chan,1)
    if any(intersect(rez.Chan{i},par.chs{2}))
        clustNr = [clustNr i];
    end   
end

for i = 1:length(clustNr)
    
    index = rez.st(logical(rez.st(:,end) == clustNr(i)),1);
    %index(index > 54149120) = []; %check this part it due to the concatunation
    
    indexH{i} = index;
    for ii = 1:length(index)
        if (index(ii) >= size1-length(xAxis) || index(ii) <= length(xAxis))
        
            fprintf('The range is to big\n')
        else
            dataTrace{i}(:,:,ii) = data(xAxis+index(ii),:);
        end
    end
end


end

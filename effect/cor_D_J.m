function [] = cor_D_J(par,rez,data,indexJ)

backwards = 10*33;
forwards = 10*33;

[dataTrace, clustNr,indexH]= traceDSort(par,rez,data);


% clustNr = [];
% for i = 1:size(rez.Chan,1)
%     if any(intersect(rez.Chan{i},par.template_LFP{2}))
%         clustNr = [clustNr i];
%     end   
% end
% for i = 1:length(clustNr)
%     index = rez.st(logical(rez.st(:,end) == clustNr(i)),1);
%     indexH{i} = index;
%     %indeindexx(index > 54149120) = []; %check this part it due to the concatunation
%     for ii = 1:length(index)
%         dataTrace{i}(:,:,ii) = data(par.xAxis+index(ii),:);
%     end
% end


b = {};holderL={}; maxC={};

for i = 1:length(clustNr)
    holder = [];holderLightCorV = [];maxV = [];
    
    for ii = 1:length(indexH{i})
        if any(find(indexH{i}(ii)-backwards < indexJ & indexH{i}(ii)+forwards  > indexJ))
            
            holder  = [holder indexH{i}(ii)];
            
            [~, index] = min(abs(indexJ-indexH{i}(ii)));
            holderLightCor = indexH{i}(ii) -indexJ(index);
            holderLightCorV = [holderLightCorV holderLightCor];
            [~, indexLFP] = max(data(indexJ(index)+[1:forwards],:));
            maxV = [maxV; indexLFP];
        end
        b{i} = holder;
        holderL{i} = holderLightCorV;
        maxC{i} = maxV;
    end
end


xAxis= backwards:forwards;

for i = 1:length(clustNr)
    figure
    histogram(holderL{i},xAxis)
    
end


for ii = 1:4
    for i = 1:length(clustNr)
        figure
        hold on
        histogram(holderL{i},xAxis)
        histogram( maxC{i}(:,ii),xAxis)
    end
    
end


end

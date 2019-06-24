function [] = shuffleCorrelation(data,meanTemplateNr,shufflesL,threshold,strTitle)

signal = [zeros(20,size(data,2))' mean(data,3)' zeros(20,size(data,2))']';

s = RandStream('mlfg6331_64');

count = 0;
for n = 1:shufflesL
    
    y = datasample(s,1:size(data,3),meanTemplateNr,'Replace',false);
    holder = zeros(size(data,1),size(data,2));
    %holder = zeros(200,size(data,2));
    
    
    for m = 1:meanTemplateNr
        holder = holder +  data(:,:,y(m));
    end
    
    template = mean(holder,3);
    
    NCC_value = normxcorr2_mex(template,signal);
    NCC_value = NCC_value(:,size(data,2));
    
    hdNCC_value(n) = max(NCC_value);
    
    if max(NCC_value) < threshold
        count = count + 1;  
        yMatrix(count,:) = y;
    end
        
    if  (0 && hdNCC_value(n) < threshold)
        figure
        subplot(1,2,1)
        surf(template)
        subplot(1,2,2)
        surf(mean(data,3))
    end
    
    
end

edges = unique(yMatrix);
counts = histc(yMatrix(:), edges);

meanH = mean(counts);
stdH = std(counts);




thresholdPass  = stdH/meanH;
thresholdPass2 = stdH/(2*meanH)+meanH;
meanPlot = mean(counts);

figure
subplot(2,1,1)
histogram(hdNCC_value,100)
title(strTitle)
xlabel('NCC-score')
ylabel('Counts')
xlim([0 1])
subplot(2,1,2)
histogram(hdNCC_value,100)
title(strTitle)
xlim([0 0.7])
xlabel('NCC-score zoom')
ylabel('Counts')
ylim([0 50])


figure
bar(edges,counts)
title(strTitle)
hold on
plot([0 max(edges)],[thresholdPass thresholdPass],'r-','DisplayName','threshold')
plot([0 max(edges)],[meanPlot meanPlot],'g-','DisplayName','mean')
plot([0 max(edges)],[thresholdPass2 thresholdPass2],'y-','DisplayName','thresholdPass2')
legend

above = length(find(counts>thresholdPass2));

fprintf('%s - Spikes above threshold: %d\n',strTitle,above)

end


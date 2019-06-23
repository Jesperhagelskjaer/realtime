function [par] = shuffleCorrelation_v2(par,data,meanTemplateNr,shufflesL,threshold,strTitle)

signal = [zeros(20,size(data,2))' mean(data,3)' zeros(20,size(data,2))']';

s = RandStream('mlfg6331_64');
yMatrix = [];
for n = 1:size(data,3) %each spike
    for i = 1:shufflesL %number of times
        
        y = datasample(s,1:size(data,3),meanTemplateNr,'Replace',false);
        
        holder = data(:,:,n);
        for m = 1:meanTemplateNr
            holder = holder +  data(:,:,y(m));
        end
        
        template = mean(holder,3);
        
        NCC_value = normxcorr2_mex(template,signal);
        NCC_value = NCC_value(:,size(data,2));
        
        hdNCC_value((n-1)*shufflesL+i) = max(NCC_value);
        
        if max(NCC_value) < threshold
            yMatrix = [yMatrix , [n y]'];
        end
        
        
    end
end
edges = unique(yMatrix);
counts = histc(yMatrix(:), edges);

edges1 = 1:size(data,3);
counts1 = zeros(1,size(data,3));
counts1(edges) = histc(yMatrix(:), edges);


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

edges3 = unique(counts1);
counts3 = histc(counts1(:), edges3);

sumV = sum(counts3);
cumsumV = cumsum(counts3);
diff_cumsumV = diff(cumsumV)/sumV*100;

index = find( diff_cumsumV < par.Cumsum, 1 );

figure
subplot(2,2,1)
bar(edges1,counts1,'HandleVisibility','off')
title(strTitle)
xlabel('Spike number')
ylabel('Count')
hold on
plot([0 max(edges1)],[index index],'g-','DisplayName','4 procent')
legend
xlabel('Total number')
ylabel('Count')
nbin = -0.5:1:max(counts1)+0.5;
subplot(2,2,3)
histogram(counts1,nbin)
hold on
plot([index+0.5 index+0.5],[0 100])
title(strTitle)
subplot(2,2,2)
plot(cumsum(counts3))
title(strTitle)
xlabel('Threshold index')
ylabel('cunsum')

above = length(find(counts1>index));


indexAbove = find(counts1>index);
fprintf('%s - Spikes above threshold: %d\n',strTitle,above)

if strcmp(strTitle,'Dsort')
    par.counts_D = counts1;
    par.D = index;
    par.indexAbove_D = indexAbove;
else
    par.counts_J     = counts1;
    par.J            = index;
    par.indexAbove_J = indexAbove;
end

end



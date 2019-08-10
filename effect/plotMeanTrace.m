function [] = plotMeanTrace(par,dataT_J,dataT_D)

meanTrace_J = mean(dataT_J,3);

for i = 1:size(dataT_D,2)
    meanTrace_D(:,:,i) = mean(dataT_D{i},3);
end

maxV = max(max(max(meanTrace_D)));
if maxV < max(max(meanTrace_J))
    maxV = max(max(meanTrace_J));
end
minV = min(min(min(meanTrace_D)));

if minV > min(min(meanTrace_J))
    minV = min(min(meanTrace_J));
end




figure
for i = 1:size(meanTrace_J,2)
    subplot(1,4,i)
    hold on
    plot(meanTrace_J(:,i),'DisplayName','J')
    for ii = 1:size(meanTrace_D,3)
        plot(meanTrace_D(:,i,ii),'DisplayName','D')
    end
    ylim([minV-10 maxV+10])
    handleFigurePlot
    xlim([0 length((par.xAxis))])
    plot([0 33],[maxV+10 maxV+10],'k')
end
legend


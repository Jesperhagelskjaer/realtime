function [] = plot_Interval_csc_with_event(par,dataTraceJ)

lgt= length(par.chs);
figure
index = find(par.xAxis == 0);
for i = 1:lgt 
    subplot(lgt+1,1,i)
    hold on
    plot(dataTraceJ(:,i,i))
    plot([index index],[min(dataTraceJ(:,3,i)) max(dataTraceJ(:,3,i))])
    handleFigurePlot
end

subplot(subplot(lgt+1,1,i+1))
plot([0 33],[index index])
xlim([min(par.xAxis) max(par.xAxis)])
handleFigurePlot

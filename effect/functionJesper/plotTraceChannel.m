function [] = plotTraceChannel(par,dataT_J,dataT_D)

m = size(dataT_D,2)+1;
n = size(dataT_J,2);

h = gobjects(m,n);


for i = 1:n
    h(i) = subplot(m,n,i);
    xlabel('Time  [Samples]')
    ylabel('Voltage [uV]')
    hold on
    for ii = 1:50%size(data,3)
        plot(dataT_J(:,i,ii))        
    end
    handleFigurePlot
    xlim([0 length((par.xAxis))])
end

for tem = 1:m-1
    for i = 1:n
        h(i) = subplot(m,n,(n*tem)+i);
        xlabel('Time  [Samples]')
        ylabel('Voltage [uV]')
        hold on
        for ii = 1:141 %size(dataT_D{tem},3)
            plot(dataT_D{tem}(:,i,ii))
        end
        handleFigurePlot
        xlim([0 length((par.xAxis))])
    end
end

end




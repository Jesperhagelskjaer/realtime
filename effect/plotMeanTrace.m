function [] = plotMeanTrace(par,dataT_J,dataT_D,varargin)

if find(strcmp(varargin,'time'))
    xVariable = varargin{find(strcmp(varargin,'time')) + 1};
    if strcmp(xVariable,'sample')
        xAxis = par.interval(1):par.interval(2);
        xL = 'Time [samples]';
    elseif strcmp(xVariable,'ms')
        xAxis = (par.interval(1):par.interval(2))/30;
        xL = 'Time [ms]';
    end
end

meanTrace_J = mean(dataT_J{1},3);

for i = 1:size(dataT_D,2)
    meanTrace_D(:,:,i) = mean(dataT_D{i},3);
end

meanTrace_J = mean(dataT_J{1},3);
test = cat(3,meanTrace_D,meanTrace_J);

figure
for i = 1:size(meanTrace_J,2)
    subplot(1,4,i)
    hold on
    plot(xAxis,meanTrace_J(:,i),'DisplayName','J')
    for ii = 1:size(meanTrace_D,3)
        plot(xAxis,meanTrace_D(:,i,ii),'DisplayName','D')
    end
    %h = get(gca,'Ylim');
    handleFigurePlot
    xlabel(xL)
    if i == 1
        ylabel('Voltage [uV]')
    end
    title(['Channel ',num2str(par.chs{2}(i))])
    legend({'JS-1','DS-1','DS-2'},'location','south east');
    legend('boxoff')
    %xlim([0 length((par.xAxis))])
    %plot([0 33],[maxV+10 maxV+10],'k')
end
legend





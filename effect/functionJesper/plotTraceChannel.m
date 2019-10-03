function [] = plotTraceChannel(par,dataT_J,dataT_D,varargin)

if find(strcmp(varargin,'time'))
    xVariable = varargin{find(strcmp(varargin,'time')) + 1};
    if strcmp(xVariable,'sample')
        xAxis = par.interval(1):par.interval(2);
        xl = 'Time  [Samples]';
    elseif strcmp(xVariable,'ms')
        xAxis = (par.interval(1):par.interval(2))/30;
        xl = 'Time [ms]';
    end
end



m = size(dataT_D,2)+1;
n = size(dataT_J{1},2);

h = gobjects(m,n);
if 0
%% used tp plot all the clusters in a subplot    
figure
for i = 1:n
    h(i) = subplot(m,n,i);
    xlabel(xl)
    ylabel('Voltage [uV]')
    hold on
    for ii = 1:size(dataT_J{1},3)
        plot(xAxis,dataT_J{1}(:,i,ii))        
    end
    %handleFigurePlot
    %xlim([0 length((par.xAxis))])
    %handleFigurePlot
    
end
%title(['Spkies: ' num2str(size(dataT_J{1},3))])
for tem = 1:m-1
    for i = 1:n
        h(i) = subplot(m,n,(n*tem)+i);
        xlabel(xl)
        ylabel('Voltage [uV]')
        hold on
        for ii = 1:size(dataT_D{tem},3)
            %plot(dataT_D{tem}(:,i,ii))
        end
        test = squeeze(dataT_D{tem}(:,i,:))';
%        stdshade_sorting_J(test)
        %handleFigurePlot
        %xlim([0 length((par.xAxis))])
        %handleFigurePlot
    end
    %title(['Spkies: ' num2str(size(dataT_D{tem},3))])
end
end
%% used for thesis
figure
for i = 1:n
    h(i) = subplot(1,n,i);
    xlabel(xl)
    %ylabel('Voltage [uV]')
    hold on
    for ii = 1:size(dataT_J{1},3)
        plot(xAxis,dataT_J{1}(:,i,ii))        
    end
    if i == 1
        ylabel('Voltage [uV]');
        %title(['Spikes: ' num2str(size(dataT_J{1},3))]);
    end
    title(['Channel ',num2str(par.chs{2}(i))])
    %handleFigurePlot
    %xlim([0 length((par.xAxis))])
    handleFigurePlot
    ylim([-200 125])
    
end

for tem = 1:m-1
    figure
    for i = 1:n
        h(i) = subplot(1,n,i);
        xlabel(xl)
        if i == 1
            ylabel('Voltage [uV]')
           % title(['Spikes: ' num2str(size(dataT_D{tem},3))])
        end
        hold on
        for ii = 1:size(dataT_D{tem},3)
            plot(xAxis,dataT_D{tem}(:,i,ii))
        end
        %test = squeeze(dataT_D{tem}(:,i,:))';
%        stdshade_sorting_J(test)
        %handleFigurePlot
 %       xlim([0 length((par.xAxis))])
        title(['Channel ',num2str(par.chs{2}(i))])
        handleFigurePlot
        ylim([-200 125])
    end   
end





end




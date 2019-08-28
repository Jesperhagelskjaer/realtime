function plotChannelsTemplateAdded(dataRAWShort,dataAdTemp,jesper)

lengthPlot = 60000;

multipl = -3;
dataAdTemp = dataAdTemp(1:lengthPlot,:);
fs = jesper.fs;
fshigh = 100;
fslow = 5000;
time = lengthPlot/fs;
[b1, a1] = butter(3, [fshigh/fs, fslow/fs]*2,'bandpass');


dataFilterede = filter(b1, a1, dataAdTemp);

% figure
% plot(dataRAWShort(1:3e4,jesper.channelMapTo(1)))
% title('Data Raw')
% xlabel('Samples')
% ylabel('Voltage [uV]')

holderPlot = jesper.GT(jesper.GT < lengthPlot);
stdValueMult = multipl * std(dataFilterede,1);
box off
minValue =  dataFilterede(holderPlot,jesper.channelMapTo);

minValuePlot = min(min(jesper.templateAverageBigCh));
maxValuePlot = max(max(jesper.templateAverageBigCh));

timeAxis = (1: lengthPlot)/fs;
figure

set(gcf,'color','w');

% for i = 1:length(jesper.mainChannel)
%      subplot(4,2,count)
%      plot(jesper.templateAverageBigCh(:,jesper.channelMapTo(i)))
%      count = count + 2;
%      ylim([minValuePlot-10 maxValuePlot+10])
%      xlabel('Samples [s]')
%      ylabel('Voltage [uV]') 
%      title(['channel: ',num2str(jesper.channelMapTo(i))])
%      
% end
count = 1;
for i = 1:length(jesper.mainChannel)
    dataToPlot = dataFilterede(1:lengthPlot,jesper.channelMapTo(i));
    subplot(4,1,i)
    plot(timeAxis,dataToPlot)
    hold on
    plot(holderPlot/fs,minValue(:,i),'or')
    plot([0 lengthPlot],[stdValueMult(jesper.channelMapTo(i))  stdValueMult(jesper.channelMapTo(i))])
    xlim([0 timeAxis(end)])
    ylim([-250 250])
    if i < length(jesper.mainChannel) 
    set(gca,'xtick',[]);
    set(gca,'xcolor',[1 1 1])
    end
    ylabel('Voltage [uV]') 
    count = count + 2;
    %title(['channel: ',num2str(jesper.channelMapTo(i))])
    box off
    set(0,'defaultAxesFontSize',20);
end
set(gca,'TickDir','out'); 
xlabel('Time [s]')


end


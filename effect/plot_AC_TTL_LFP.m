function [] = plot_AC_TTL_LFP(par,data)

minR = find(par.xAxis == 0);

data = data{1};
% for i = 1:10
%     figure
%     plot(par.xAxis, data(:,4,i));
%     
% end

for i = 1:size(data,3)
    [~, minMatrix(:,i)] = min(data(1:minR,:,i));
    [~, maxMatrix(:,i)] = min(data(minR+10:end,:,i));
%     h = figure;
%     plot(data(:,1,i))
%     close(h)
end

minMatrix = minMatrix - minR;
figure
holder_l = ({'min AP','max LFP'});
for i =1:size(data,2)
   
    subplot(2,2,i)
    histogram(minMatrix(i,:)/30,par.xAxis/30)
    hold on
    histogram(maxMatrix(i,:)/30,par.xAxis/30)
    handleFigurePlot()
    ylabel('Counts')
    xlabel('Time [ms]')
    if i == 1
    %plot([0 33],[600 600],'k')
    end
    legend(holder_l);
    legend('boxoff')
    title(['Channel ',num2str(par.chs{2}(i))])
 end

end


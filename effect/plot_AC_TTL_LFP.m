function [] = plot_AC_TTL_LFP(par,data)

minR = find(par.xAxis == 0);

% for i = 1:10
%     figure
%     plot(par.xAxis, data(:,4,i));
%     
% end

for i = 1:size(data,3)
    [~, minMatrix(:,i)] = min(data(1:minR,:,i));
    [~, maxMatrix(:,i)] = max(data(minR:end,:,i));
end

minMatrix = minMatrix - minR;
figure

for i =1:size(data,2)
   
    subplot(2,2,i)
    histogram(minMatrix(i,:),par.xAxis)
    hold on
    histogram(maxMatrix(i,:))
    handleFigurePlot
    ylabel('Counts')
    if i == 1
    plot([0 33],[600 600],'k')
    end
 end

end


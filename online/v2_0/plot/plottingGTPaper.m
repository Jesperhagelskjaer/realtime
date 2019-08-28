function [outputArg1,outputArg2] = plottingGTPaper(jesper,dataFilt,iCHT,iCHTre,rez)

dataStatisk = jesper.statistisk;

index = find(isnan(dataStatisk),1);

dataStatisk(isnan(dataStatisk)) = [];

values = reshape(dataStatisk',[index-1, length(dataStatisk)/(index-1)]); 

size2 = size(values,2);

toValue1 = 210;
toValue2 = 900;
scale = toValue1/toValue2;

together(1,1:size2) = values(4,1:size2);together(2,1:size2) = values(3,1:size2) *scale;

figure
bar_handle = bar(together','grouped');
set(bar_handle(1),'FaceColor','k')
set(bar_handle(2),'FaceColor','b')
ylim([0 toValue1])
yticks([0 toValue1/2 toValue1])
ylabel('False Negative')
hold on
yyaxis right
ylim([0 toValue2])
yticks([0 toValue2/2 toValue2])
ylabel('False Positive')
box off
xticklabels({'NCC', 'Neg', 'Pos','Grad','Coh'})
set(gca,'TickDir','out')
ax = gca;
set(ax(1),'ycolor','b')
set(gca,'FontSize',22)
set(gcf,'color','w')





% figure
% hold on
% xlim([0.5 5.5])
% xticks([0.5 1 2 3 4 5 5.5])
% xticklabels({'','NCC','Neg','Pos','Grad','Coh',''})
% yyaxis left 
% plot(test1(4,:))
% yticks([110 135 160])
% ylabel('Fa')
% ylabel('False Negative [Counts]')
% yyaxis right 
% plot(test1(3,:))
% ylabel('False Positive [Counts]')
% yticks([0 100 200])
% set(gca,'TickDir','out');







end


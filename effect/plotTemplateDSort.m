function [] = plotTemplateDSort(rez,template)


for i = 1:32
h = figure;
plot(rez.M_template(10:45,i,template))
% h.CurrentAxes.YTick = {};
% h.CurrentAxes.YTick = {};

color = get(h,'Color');
set(gca,'XColor',color,'YColor',color,'TickDir','out')


end

end


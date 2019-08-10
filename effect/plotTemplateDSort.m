function [] = plotTemplateDSort(rez,template)


for i = 28:32
figure;
plot(rez.M_template(10:45,i,template))
% h.CurrentAxes.YTick = {};
% h.CurrentAxes.YTick = {};

%set(gcf,'color','w');
set(gca,'color','none')
%set(gca,'XColor',[1 1 1],'YColor',[1 1 1],'TickDir','out')
set(gca,'XColor','none','YColor','none','TickDir','out')
%save_path = 't1';
%export_fig(save_path, '-png', '-transparent');
end

end


function [] = plotOneTrace(par,data,TTL_number,total)




if strcmp(total,'single') == 1
    for i = 1:size(data,2)
        figure;
        plot(par.xAxis,data(:,i,TTL_number))
    end
else
    figure
    surf(data(:,:,TTL_number))
end
end





%color = get(h,'Color');
%set(gca,'color','none')
%set(gca,'XColor',[1 1 1],'YColor',[1 1 1],'TickDir','out')
%set(gca,'XColor','none','YColor','none','TickDir','out')

% set(gca,'Visible','off')
%xticks([0 6000])
%xticklabels({'0','200'})
%xlabel('Time [ms]')
%box off
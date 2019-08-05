function [] = plotOneTrace(data,TTL_number)

for i = 1:size(data,2)
    h = figure;
    plot(data(:,i,TTL_number))
    color = get(h,'Color');
    %set(gca,'XColor',color,'YColor',color,'TickDir','out')
    %set(gca,'YColor',color,'TickDir','out')
    
    set(gca,'Visible','off')
    xticks([0 6000])
    xticklabels({'0','200'})
    xlabel('Time [ms]')
    box off
  
end



end


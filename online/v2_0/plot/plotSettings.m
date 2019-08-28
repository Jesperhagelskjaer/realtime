function [] = plotSettings(boolV)
    set(0, 'DefaultLineLineWidth', 2);
    set(0,'defaultAxesFontSize',20);
    set(gca,'TickDir','out');
    set(gcf,'color','w')
    box off
    set(gca,'linewidth',3)
    
    if (boolV == 1)
        xlabel('Samples')
        ylabel('Voltage [uV]')
        xlim([0 60])
        xticks([0,30, 60])
        
        ylim([-150 100])
        yticks([-150    0   100])
    elseif (boolV == 2)
        ylabel('Samples')
        xlabel('Channels')
        zlabel('Voltage [uV]')
    end

end


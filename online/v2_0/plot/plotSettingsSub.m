function [] = plotSettingsSub(ii,boolV,string)

    set(0, 'DefaultLineLineWidth', 2);
    set(0,'defaultAxesFontSize',20);
    set(gca,'TickDir','out');
    set(gcf,'color','w')
    box off
    set(gca,'linewidth',3)
    
    if (ii == 1 && boolV == 1)
        title('GT')
    elseif (ii == 1 && boolV == 2)
        title('Noise')
    elseif (ii == 1 && boolV == 3)
        title('Template and Noise')
    elseif (ii == 1 && boolV == 4)
        title('Templte not moved')
    elseif (ii == 1 && boolV == 5)
        title('Template and Noise - Cut')
    end
    if (boolV == 1 || boolV == 3)
        ylabel('Counts')
    end 
    
    if (ii > 3)
        xlabel(string)
    end
    
%         xlim([0 60])
%         xticks([0,30, 60])
%         
%         ylim([-150 100])
%         yticks([-150    0   100])
 

end
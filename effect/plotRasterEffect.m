function [] = plotRasterEffect(par,rezT_,RasterR1_)
X = -par.before:1:par.after;

template_ = par.template;

for i = 1:length(unique(rezT_{2}.rez.st(:,8)))
    h =figure;
    sgtitle(['Templates - ',num2str(template_),' -> ',num2str(i)])
    
    subplot(2,3,1)
    bar(X, RasterR1_{1,i})
    title(['Before'])
    
    subplot(2,3,4)
    bar(X, RasterR1_{2,i})
    title(['After'])
    xlabel('time [ms]')
    ylabel('# counts')
    
    
    subplot(2,3,2)
    surf(rezT_{1}.rez.M_template(:,:,template_))
    title(['template - ', num2str(par.template)])
    
    subplot(2,3,3)
    surf(rezT_{1}.rez.M_template(:,:,i))
    title(['template - ', num2str(template_)])
    
    
    subplot(2,3,5)
    surf(rezT_{2}.rez.M_template(:,:,i))
    title(['template - ',num2str(i)])
    
    subplot(2,3,6)
    surf(rezT_{2}.rez.M_template(:,:,i))
    title(['template - ',num2str(i)])
    name = strcat(par.path{1},par.e_str,'figure\',num2str(par.template),'_',num2str(i));
    saveas(h,name,'fig')

end


function [outputArg1,outputArg2] = plotRasterEffectV2(par,rezT,RasterR1)
X = -par.before:1:par.after;

template_ = par.template;

for i = 1:size(RasterR1,2)
    
    h =figure;
    sgtitle(['Templates - ',num2str(template_),' -> ',num2str(i)])
    
    subplot(2,2,1)
    bar(X, RasterR1{1,i})
    title(['Before'])
          
    subplot(2,2,2)
    surf(rezT{1}.rez.M_template(:,:,template_))
    title(['template - ', num2str(par.template)])
    
    
    subplot(2,2,3)
    bar(X, RasterR1{2,i})
    title(['After'])
          
    subplot(2,2,4)
    surf(rezT{1}.rez.M_template(:,:,i))
    title(['template - ', num2str(i)])
    

end




end


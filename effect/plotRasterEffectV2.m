function [] = plotRasterEffectV2(par,rez,RasterR1)
X = -par.before:1:par.after;

template = par.template;

for i = 1:size(RasterR1,2)
    
    h = figure('units','normalized','outerposition',[0 0 1 1]);
    sgtitle(['Templates - ',num2str(template),' -> ',num2str(i)])
    
    subplot(2,3,1)
    bar(X, RasterR1{1,i})
    title(['Before'])
      
    
    subplot(2,3,2)
    surf(rez.M_template(:,:,template))
    title(['template - ', num2str(par.template)])
    view(0,0) 
    
    subplot(2,3,4)
    bar(X, RasterR1{2,i})
    title(['After'])
          
    subplot(2,3,5)
    surf(rez.M_template(:,:,par.clustNr(i)))
    title(['template - ', num2str(i)])
    view(0,0) 
    
    subplot(2,3,3)
    surf(par.figureLight)
    title(['light template real-time classi'])
    view(0,0) 
    
end




end


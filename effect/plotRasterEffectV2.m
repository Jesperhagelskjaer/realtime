function [] = plotRasterEffectV2(par,rez,RasterR1)

X = par.interval(1):par.interval(2);

template = par.template;
for ii = 1:size(par.path,2)
for i = 1:size(RasterR1,2)
    
    h = figure('units','normalized','outerposition',[0 0 1 1]);
    sgtitle(['Templates - ',num2str(template),' -> ',num2str(par.clustNr(i))])
    
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
    title(['template - ', num2str(par.clustNr(i))])
    view(0,0) 
    
    subplot(2,3,3)
    surf(par.figureLight)
    title(['Light temp RT classification'])
    view(0,0) 
    
end
end



end


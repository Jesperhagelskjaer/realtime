function [jesper] = filterTemplate(jesper)
tic
fprintf('Filtering template started')
template  = jesper.templateAverageBig; 
templateP = jesper.templateAverageBig; 

if strcmp(jesper.filtertype,'butter')
    templateBigF = filterButter(jesper.fslow,jesper.fshigh,template,jesper);
end


[minV,minI] = min(templateP(:,jesper.chMain));

jesper.templateBigF = templateBigF; 

if strcmp(jesper.plotFilterOneTemplate,'Y')
   
    figure
    plot(templateBigF(:,jesper.chMain))
    plotSettings(1)
    
    %figure
    %surf(templateBigF(:,:))
    %plotSettings(2)
    
    %figure
    %plot(templateP(:,jesper.chMain))
    %plotSettings(1)

end
    
    
end


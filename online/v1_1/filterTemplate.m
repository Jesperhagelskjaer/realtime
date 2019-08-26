function [jesper] = filterTemplate(jesper,iFilH,iFilL)
tic
fprintf('Filtering template started')
template  = jesper.templateAverageBigCh; 
templateP = jesper.templateAverageBigCh; 

if strcmp(jesper.filtertype,'butter')
    templateBigF = filterButter(jesper.fslow(iFilL),jesper.fshigh(iFilH),template,jesper);
elseif strcmp(jesper.filtertype,'ellip')
    templateBigF = filterEllip(jesper.fslow(iFilL),jesper.fshigh(iFilH),template,jesper);
    
elseif strcmp(jesper.filtertype,'rect')
    ekstraLength = jesper.TAPS;
          
    zTemplate = zeros(ekstraLength,jesper.spatial);
    template = vertcat(zTemplate,jesper.templateAverageBigCh);
    template = vertcat(template,zTemplate); %new addition
    templateBigF = filterRect(jesper.fslow(iFilL),jesper.fshigh(iFilH),template,jesper);

    templateBigF(1:ekstraLength+ekstraLength/2,:) = [];
    templateBigF(end-ekstraLength/2:end,:) = [];
else
    fprintf('Something wrong in filterTemplate')
    exit();
    
end

jesper.templateBigF = templateBigF; 

if strcmp(jesper.plotFilterOneTemplate,'Y')
    figure
    plot(templateBigF(:,jesper.channelMapTo(1)))
    title('Filtered')
    xlabel('Samples')
    ylabel('Voltage [uV]')
    ylim([-200 150])
    figure
    plot(templateP(:,jesper.channelMapTo(1)))
    title('Raw template')
    xlabel('Samples')
    ylabel('Voltage [uV]')
end
    
    
end


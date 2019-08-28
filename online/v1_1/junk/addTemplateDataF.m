function [dataTemplate,r] = addTemplateDataF(dataRAW,jesper)

t1 = -jesper.sizeTemplateIntoRawData:jesper.sizeTemplateIntoRawData;
t2 = jesper.lengthGroundt;
spTotal = jesper.spikesTotal;
r = randi([0 (t2-length(t1))],1, spTotal);
template = jesper.templateAverageBigCh; 

dataTemplate = dataRAW;

for i = 1:length(r)
    dataTemplate(r(i)+t1,:) = dataRAW(r(i)+t1-1,:) + template;    
    if (0 && i < 50) 
        figure('units','normalized','outerposition',[0 0 1 1])
        subplot(2,1,1)
        surf(dataRAW(r(i)+t1-1,jesper.channelMapTo))
        title('Data no template')
        view(90,0)
        subplot(2,1,2)
        surf(dataTemplate(r(i)+t1-1,jesper.channelMapTo))
        title('Data added templates')
        view(90,0)
    end
end

end
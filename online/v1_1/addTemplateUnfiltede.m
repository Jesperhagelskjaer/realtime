function [dataTemplate,r] = addTemplateUnfiltede(dataRAW,jesper)

t1 = -jesper.sizeTemplateIntoRawData:jesper.sizeTemplateIntoRawData;
t2 = jesper.lengthGroundt;
spTotal = jesper.spikesTotal;
r = randi([0 (t2-length(t1))],1, spTotal);
r = sort(r);
template = jesper.templateAverageBigCh; 
dataRAW = double(dataRAW);
dataTemplate = dataRAW;

for i = 1:length(r)
    dataTemplate(r(i)+t1,:) = dataRAW(r(i)+t1-1,:) + template;
    if 0
        figure('units','normalized','outerposition',[0 0 1 1])
        subplot(2,1,1)
        %surf(dataRAW(r(i)+t1-1,:))
        plot(dataRAW(r(i)+t1-1,29))
        title('DataF not add template')
        %view(90,0)
        subplot(2,1,2)
        %surf(dataTemplate(r(i)+t1-1-1,:))
        plot(dataTemplate(r(i)+t1-1,29))
        title('DataF added template')
        %view(90,0)
    end
    
    
end


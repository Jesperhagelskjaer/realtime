function plotAddTemplateData(jesper,dataAdTempF)

t1 = -jesper.sizeTemplateIntoRawData:jesper.sizeTemplateIntoRawData;

r = jesper.GT;
if strcmp(jesper.plotTemAddF,'Y')
    for i = 1:50
        figure('units','normalized','outerposition',[0 0 1 1])
        subplot(2,1,1)
        surf(dataAdTempF(r(i)+t1-1,jesper.channelMapTo))
        view(90,0)
        subplot(2,1,2)
        surf(dataAdTempF(r(i)+t1-1,:))
    end
end
end


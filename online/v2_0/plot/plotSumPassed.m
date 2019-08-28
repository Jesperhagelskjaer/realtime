function [] = plotSumPassed(par,dataF,rez,stringToPlot,plotV)

temporal    = par.lengthTemplate;
mChls       = par.mainChannel;
indexCheck  = par.passed;

lgt1 = length(par.mainChannel);
figure('NumberTitle', 'off', 'Name',stringToPlot);

figure
for ch = 1:lgt1
    subplot(lgt1,1,ch)
    for i = 1:length(indexCheck)
        hold on
        %plot(dataF(indexCheck(i)-[1:temporal],mChls(ch)))  
        plot(dataF(indexCheck(i)+[-40:10],mChls(ch)))
        title(stringToPlot)
        xlabel('Samples')
    end
end
end





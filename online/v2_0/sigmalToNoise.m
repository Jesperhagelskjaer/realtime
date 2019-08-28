function [jesper] = sigmalToNoise(dataRAW,dataF,jesper)



if strcmp(jesper.changeChannels,'YES')
    mChls = jesper.channelMapTo;
else
    mChls = jesper.mainChannel;
end

[templateMin,~] = min(jesper.templateAverageBig(:,jesper.mainChannel)); %unfiltered template 
[templateFilMin,~] = min(jesper.reCalculateTemplate(:,mChls));



stdRaw = std(double(dataRAW(:,mChls)),1);
stdFiltered = std(dataF(:,mChls),1);

jesper.SNRUnFilteredmean = mean(10*log10((templateMin./stdRaw).^2))
jesper.SNRfiltedmean = mean(10*log10((templateFilMin./stdFiltered).^2))

end


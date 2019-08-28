function PlotMinMaxHeight2D(par,dataF,rez,stringToPlot,plotV)

[par] = calMinMax(par,dataF,rez);

lgt1 = length(par.mainChannel);
figure('NumberTitle', 'off', 'Name',stringToPlot);

for i = 1:length(par.mainChannel)
    
    if strcmp(par.useBitmVolt,'Y')
        binranges = min(min(par.holder)):10:50;
        xString = 'Volt [uV]';
    else
        binranges = min(min(par.holder)):10:50;
        xString = '[Arb.U.]';
    end
    
    [bincounts2] = histc(par.holder(:,i),binranges);
    
    subplot(lgt1,1,i)
    bar(binranges,bincounts2,'histc')
    %plotSettingsSub(3,1)
    
    
    
    
    
end

end








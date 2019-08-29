function PlotMinMaxHeight2D(par,dataF,rez,stringToPlot,plotV)

[par] = calMinMax(par,dataF,rez);

lgt1 = length(par.template{2});
figure('NumberTitle', 'off', 'Name',stringToPlot);

plotColour(par.holder);



for i = 1:length(par.template{2})
    
    if strcmp(par.useBitmVolt,'Y')
        binranges = min(min(par.holder)):10:50;
        xString = 'Volt [uV]';
    else
        binranges = min(min(par.holder)):10:50;
        xString = '[Arb.U.]';
    end
    
    [bincounts2] = histc(par.holder(:,i),binranges);
    
    subplot(lgt1,1,i)
    bar(binranges,bincounts2,'histc') %[0:1/length(bincounts2-1):100]
    %plotSettingsSub(3,1)  
end

end








close all
clc

try
    [holder] = clearAllExpectDatum(datum);
    clearvars -except holder %before very carefull of this, will not work when changing the path
    datum.data_NRD_RAW = holder;
    clear holder
catch
    clear
    datum = [];
end

[par]               = parameter();

[par,rez]           = loadRez(par);

[datum,par]         = loadRawData(par,datum);

while 1
    
    [datum]             = filterMain(par,datum,'ext','csc');
    
    plotRealDataTemplate(par,datum,rez,'ext','csc');
    close all
    
    [par]               = recalculateTemplate(par,rez,datum,'ext','csc');
    
    load('templateToUse.mat')
    
    figure
    surf(meanTest(:,41:56))
    par.templateAverageBig = templateAverageBig;
    par.templateAverageBig_NRD = templateAverageBig;
    
    [par]               = coherenceParameter(par,datum,'ext','csc');
    
    %Used to calculate the template length
    [par]               = cutRecalculateNCCTemplate(par,datum,'ext','csc');
    
    %old way to calcualte template
    %[par]               = recalculateNCCTemplate(par,datum,rez,'ext','nrd');
    
    [par]               = NCC(par,datum,rez,'ext','csc');
    
    [par]               = allChlsMean(par,datum,rez,'ext','csc');
    
    [par]               = minMaxHeight2D(par,datum,rez,'ext','csc');
    
    
    [par] = guiMain(par);
    
    if isempty(par.answer)
        break
    end
    
end




% if strcmp(par.upload,'Y')
%     [par] = saveTemplateBin(par);
%     %saveRAWSignal(jesper,dataRAW);
%     %butter2IIR(jesper);
%     %setupHPPmatlab(par);
%     SetupHPP2(par)
% end
%show the 2D of the minMax
%[par]               = minMaxHeightSVM2D(par,dataF,rez);


% figure
% plot(datum.data_NRD_F( 1:1e5,1))
% hold on
% plot(datum.data_NRD_RAW( 1:1e5,1))














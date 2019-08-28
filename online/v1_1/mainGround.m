%Gradident serach  (hard coded now)
%When all channels see the same fluctuation (hard coded now);
%implement the positive butter repol in the code (started)

clc
clearvars -except datum.dataRAW
close all
timerVal = tic;

[par] = parameter();

[datum,par] = loadRawData(par,datum);

[rez] = loadRez(par);

plotRealDataTemplate(par,datum.dataF,rez);

while 1 
        
    [datum] = filterMain(par,datum.dataRAW,datum);
    
    %datum.dataRawShort = datum.dataRAW(1:par.lengthGroundt,:);
    
    [par] = recalculateNCCTemplate(datum.dataF,par,rez,1,1);
    
    [par] = CppNCC(par,datum.dataF,1,1,1,rez);
    
    %[par] = allChannelsCoherenct(dataF,par);
    
   % [par] = belongotherClus(par,datum.dataF,1,1,rez,'coherency',0,datum.dataF); %not longer correct
    
    [par] = gradientCalculation(par,datum.dataF,rez);
    
    %[par] = belongotherClus(par,datum.dataF,1,1,rez,'gradient',0,datum.dataF);
    
    [par] = guiMain(par);
        
    if isempty(par.answer)
        break
    end
    
end

if strcmp(par.SAU,'Y')
    [par] = saveTemplateBin(par);
    %saveRAWSignal(par,dataRAW);
    %butter2IIR(par);
    setupHPPmatlab(par);
    %SetupHPP2(par)
end


time = toc(timerVal);

fprintf('\n%-20s %2.2f %-10s\n', 'Total Time - ',time,'seconds')


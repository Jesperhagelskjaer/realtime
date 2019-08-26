%Gradident serach  (hard coded now)
%When all channels see the same fluctuation (hard coded now);
%implement the positive butter repol in the code (started)

clc
clearvars -except datum.dataRAW
close all
timerVal = tic;

[par,datum] = parameter();

[datum,par] = loadRawData(par,datum);

[rez] = loadRez(par);
 
while 1 
        
    [par,datum.dataF] = filterMain(par,datum.dataRAW,1,1);
    
    datum.dataRawShort = datum.dataRAW(1:par.lengthGroundt,:);
    
    [par] = recalculateNCCTemplate(datum.dataF,par,rez,1,1);
    
    [par] = CppNCC(par,datum.dataF,1,1,1,rez);
    
    %[par] = allChannelsCoherenct(dataF,par);
    
    %[par] = belongotherClus(par,dataF,1,1,rez,'coherency',0,dataF);
    
    [par] = gradientCalculation(par,datum.dataF,rez);
    
    [par] = belongotherClus(par,datum.dataF,1,1,rez,'gradient',0,datum.dataF);
    
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


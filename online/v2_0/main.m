
clc
clearvars -except datum.dataRAW
close all

if ~exist('datum','var')
   datum = []; 
end

[par]               = parameter();

[par,rez]           = loadRez(par);

[datum,par]         = loadRawData(par,datum);

[datum]             = filterMain(par,datum,'ext','nrd');

%[par]               = recalculateTemplate(par,rez,datum,'ext','nrd');

[par]               = coherenceParameter(par,dataF);

% Used to calculate the template length
%[par]               = cutRecalculateNCCTemplate(dataF,par);
%old way to calcualte template
[par]               = recalculateNCCTemplate(par,datum,rez,'ext','nrd');

[par]               = NCC(par,datum,rez,'ext','nrd');

[par]               = allChlsMean(par,dataF,rez);

%show the 2D of the minMax
%[par]               = minMaxHeightSVM2D(par,dataF,rez);

[par]               = minMaxHeight2D(par,datum,rez,'ext','nrd');
                 


% if strcmp(par.upload,'Y')
%     [par] = saveTemplateBin(par);
%     %saveRAWSignal(jesper,dataRAW);
%     %butter2IIR(jesper);
%     %setupHPPmatlab(par);
%     SetupHPP2(par)
% end



figure
plot(datum.data_NRD_F( 1:1e5,1))
hold on
plot(datum.data_NRD_RAW( 1:1e5,1))














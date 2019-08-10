function [rasterMa,par] = rasterMain(par,rez)

if strcmp(par.template_LFP{1},'tp')
    [rasterMa,par] = raster(par,rez); %Raster used for template number 
elseif strcmp(par.template_LFP{1},'ch')
    [rasterMa,par] = rasterCh(par,rez); %Raster used for channels number 
end


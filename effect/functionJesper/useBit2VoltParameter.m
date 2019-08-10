function [dataRAW] = useBit2VoltParameter(dataRAW,par)

if strcmp(par.useBitmVolt,'Y')
    dataRAW = dataRAW * par.bitmVolt;
end

end


function [dataRAW] = useBit2VoltParameter(dataRAW,jesper)

if strcmp(jesper.useBitmVolt,'Y')
    dataRAW = dataRAW * jesper.bitmVolt;
end

end


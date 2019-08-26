function [dataRaw] = invertSignal(par,dataRaw)

if strcmp(par.signalInverted,'Y')
    dataRaw = dataRaw * -1;
end

end


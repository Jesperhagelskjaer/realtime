function [dataRaw] = invertSignal(dataRaw,par)

if strcmp(par.signalInverted,'Y')
    dataRaw = dataRaw * -1;
end

end


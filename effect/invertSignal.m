function [dataRaw] = invertSignal(ops,dataRaw)

if strcmp(ops.signalInverted,'Y')
    dataRaw = dataRaw * -1;
end

end


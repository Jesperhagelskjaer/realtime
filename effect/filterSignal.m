function [datr] = filterSignal(par,dataRAW)


if strcmp(par.filter, 'Y')
    [b1, a1] = butter(3, [par.fshigh/par.fs,par.slow/par.fs]*2, 'bandpass');
    datr = filter(b1, a1, dataRAW);
    datr = flipud(datr);
    %Backward filtering using butterworth coefficient
    datr = filter(b1, a1, datr);
    datr = flipud(datr);
else
    datr = dataRAW;
    
end
end


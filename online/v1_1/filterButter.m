
function [dataFilterede] = filterButter(fslow,fshigh,dataRAW,par)


filterType = par.filType;
fs = par.fs;

if strcmp(filterType,'bandpass')
    [b1, a1] = butter(par.order, [fshigh/fs, fslow/fs]*2,'bandpass');
elseif  strcmp(filterType,'high')
    [b1, a1] = butter(par.order, 2*fshigh/fs,'high');
elseif strcmp(filterType,'low')
    [b1, a1] = butter(par.order, 2*fslow/fs,'low');
else
    %%make error
end

datatF = double(dataRAW);
dataFilterede = filter(b1, a1, datatF);

end
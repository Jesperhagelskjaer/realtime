
function [dataFilterede] = filterButter2(dataRAW,jesper)


fs = jesper.fs;
fshigh = 10;
fslow = 7000;
[b1, a1] = butter(3, [fshigh/fs, fslow/fs]*2,'bandpass');


datr = filter(b1, a1, dataRAW);
datr = flipud(datr);
datr = filter(b1, a1, datr);
dataFilterede = flipud(datr);

end

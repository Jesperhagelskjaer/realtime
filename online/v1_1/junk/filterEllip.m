function  datatF = filterEllip(fslow,fshigh,dataRAW,jesper) %butterworth

fs = jesper.fs;
fpass = [fshigh/fs, fslow/fs]*2;
[b,a]=ellip(6,0.1,80,fpass);    % Bandpass digital filter design

%h = fvtool(b,a, 'OverlayedAnalysis','phase');

datatF = filter(b, a, dataRAW); 


end


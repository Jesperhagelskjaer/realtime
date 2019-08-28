
function [dataF] = filterButter(par,dataRAW)

version   = par.filtertype{3};
type      = par.filtertype{4};
fshigh    = par.filtering{1};
fslow     = par.filtering{2};
fs        = par.filtering{3};
order     = par.filtering{4};


if strcmp(version,'normal')
    if strcmp(type,'bandpass')
        [b1, a1] = butter(order, [fshigh/fs, fslow/fs]*2,type); %placement of 2
    elseif  strcmp(type,'high')
        [b1, a1] = butter(order, 2*fshigh/fs,type);
    elseif strcmp(type,'low')
        [b1, a1] = butter(order, 2*fslow/fs,type);
    else
       fprintf('Error function is paused')
    end
    dataF = filter(b1, a1, dataRAW);
    
elseif strcmp(version,'sos')
    if strcmp(type,'bandpass')
        fpass = [fshigh fslow];
        [z,p,k] = butter(order,fpass*2/fs,type);
        
    elseif strcmp(filterType,'high')
        fprintf('ERROR IN FILTERING- pause')
        pause()
    end
    sos = zp2sos(z,p,k);
    
    dataF = sosfilt(sos,dataRAW,1);  %dim operate along dimension
    
else
    fprintf('ERROR IN FILTERING')
end




end
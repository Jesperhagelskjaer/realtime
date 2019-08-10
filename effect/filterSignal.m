function [datr] = filterSignal(par,dataRAW)

if strcmp(par.filtertype{1}, 'Y')
    
    type = par.filtertype{3}; 
    fshigh = par.filtering{1};
    slow = par.filtering{2};   
    fs = par.filtering{3};
    order = par.filtering{4};
    
    [b1, a1] = butter(order, [fshigh/fs,slow/fs]*2,type);
    datr = filter(b1, a1, dataRAW);
    
    if (par.filtertype{4} ~= 1)
        datr = flipud(datr);
        %Backward filtering using butterworth coefficient
        datr = filter(b1, a1, datr);
        datr = flipud(datr);
    end
else
    datr = dataRAW;
    
end
end


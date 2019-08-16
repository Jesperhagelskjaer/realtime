function [data_Filterede] = filterButter(par,dataRAW)

for ii = 1:size(par.path,2)
    
if strcmp(par.filtertype{1}, 'Y')
   
    dataRAW= double(dataRAW{ii});
    
    type   = par.filtertype{3}; 
    fshigh = par.filtering{1};
    slow   = par.filtering{2};   
    fs     = par.filtering{3};
    order  = par.filtering{4};
    
    [b1, a1] = butter(order, [fshigh/fs,slow/fs]*2,type);
    data_Filterede = filter(b1, a1, dataRAW);
    
    if (par.filtertype{4}   == 2)
        data_Filterede = flipud(data_Filterede);
        %Backward filtering using butterworth coefficient
        data_Filterede = filter(b1, a1, data_Filterede);
        data_Filterede{ii} = flipud(data_Filterede);
    elseif (par.filtertype{4} > 2)
        fprintf('Error in filtering passes - function paused')
        pause();    
    end
    
else
    data_Filterede{ii} = dataRAW;
end
end


end
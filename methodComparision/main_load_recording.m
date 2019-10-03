function [datum] = main_load_recording(par,datum)


try exist(strcat(par.path,'event.nev'),'var')
    [datum] = loadEvent(par,datum);

    %load csc files load the light and the nonlight case
    [datum] = main_load_csc(par,datum); 

    [datum] = main_load_NRD(par,datum,par.path);

catch
end



%Make for the csc file 

 try exist(strcat(par.path,'event.nev'),'var')
     
     [datum] = loadOpenEphys(par,datum)
 catch
 end
 

    
end


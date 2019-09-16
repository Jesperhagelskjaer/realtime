function [datum] = loadEvent(par,datum)

tic
path = par.path;
for i = 1:size(path,1)
    fullNameEvents = strcat(path,'\Events.nev');
    
    [TimestampsEvent, EventIDs, TTLs, Extras, EventStrings, HeaderEvent] = Nlx2MatEV(fullNameEvents, [1 1 1 1 1], 1, 1, [] );
    
    
    TTLsCat{i} = TTLs;
    TimestampsEventCat{i} = TimestampsEvent;
    
    time = toc;
    fprintf('Nlx2MatEV: %0.2f seconds \n',time)
end

datum.TTLs = TTLsCat;
datum.TimestampsEvent = TimestampsEventCat;

end


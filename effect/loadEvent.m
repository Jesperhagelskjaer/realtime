function [TTLsCat,TimestampsEventCat] = loadEvent(path)


tic
for i = 1:size(path,1)
    fullNameEvents = strcat(path{i},'Events.nev');
    
    [TimestampsEvent, EventIDs, TTLs, Extras, EventStrings, HeaderEvent] = Nlx2MatEV(fullNameEvents, [1 1 1 1 1], 1, 1, [] );
    
    
    TTLsCat{i} = TTLs;
    TimestampsEventCat{i} = TimestampsEvent;
    
    time = toc;
    fprintf('Nlx2MatEV: %0.2f seconds \n',time)
end

end


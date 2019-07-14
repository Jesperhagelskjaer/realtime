function [TTLs,TimestampsEvent] = loadEvent(path)

tic

fullNameEvents = strcat(path,'\Events.nev');

[TimestampsEvent, EventIDs, TTLs, Extras, EventStrings, HeaderEvent] = Nlx2MatEV(fullNameEvents, [1 1 1 1 1], 1, 1, [] );
time = toc;
fprintf('Nlx2MatEV: %0.2f seconds \n',time)

end


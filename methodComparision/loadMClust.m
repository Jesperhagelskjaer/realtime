function [datum] = loadMClust(par,datum)

count = 0;

bundle = ceil(max(par.template_LFP{2})/4)-1; 
while 1
    count = count + 1;
    try 
       load(strcat(par.path,sprintf('/TT%d_0%d',bundle,count))); %change TT0,
    catch
        break
    end
    datum.tSpikes_MClust{count} = round((tSpikes-datum.First)*par.filtering{3});
end


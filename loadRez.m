function [rez] = loadRez(par)

if strcmp(par.loadRez{1},'y')
    if strcmp(par.recType,'csc')
        load(strcat(par.path,'csc\',par.loadRez{2}))
    elseif strcmp(par.recType,'nrd')
        load(strcat(par.path,'nrd\',par.loadRez{2}))
    end
end
end


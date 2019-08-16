function [rez] = loadRez(par)

load(strcat(par.path{1},'csc\',par.rezName));

end


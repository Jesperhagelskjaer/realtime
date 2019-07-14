function [rez] = loadRez(par)

load(strcat(par.path,par.name,par.rezName));

end


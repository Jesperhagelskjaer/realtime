function [rez] = loadRez(par)

load(strcat(par.path{1}, par.e_str,par.rezName));

end


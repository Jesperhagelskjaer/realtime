function [rezT] = loadRez(par)

rezT{1} = load(strcat(par.path{1}, par.e_str,par.rezName));
%rezT{2} = load(strcat(par.path{2}, par.e_str,par.rezName));

end


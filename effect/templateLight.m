function [par] = templateLight(par)

load(strcat(par.path{2}, par.e_str,par.rezName));

par.figureLight = rez.M_template(:,:,par.lightTemplate);

end


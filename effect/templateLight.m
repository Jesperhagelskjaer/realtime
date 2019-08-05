function [par] = templateLight(par)

load(strcat(par.lightPath,par.rezName));

par.figureLight = rez.M_template(:,:,par.lightTemplate);


end


function [par] = templateLight(par)

load(strcat(par.lightPath,'\csc\',par.rezName));

par.figureLight = rez.M_template(:,:,par.template);


end


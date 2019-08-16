function [par] = templateLight(par)



if any(strcmp(par.path,'L'),'all')
    [i,~] = find(strcmp(par.path,'L') == 1);

    load(strcat(par.path{i,1},'\csc\',par.rezName));

    par.figureLight = rez.M_template(:,:,par.template);

end

end

